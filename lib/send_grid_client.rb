require 'sendgrid-ruby'
require 'faraday'

class SendGrid::Mail
  alias_method :to_h_orig, :to_h

  def to_h
    payload = to_h_orig
    payload[:headers] = @headers.to_json if @headers.any?
    payload
  end
end

class SendGridClient
  @@client = SendGrid::Client.new(
    api_key: ENV["SENDGRID_KEY"],
    raise_exceptions: true
  )

  class << self
    def publish!(inbound)
      message = SendGrid::Mail.new do |m|
        m.html = inbound.html unless inbound.html.nil?
        m.text = inbound.text
        m.subject = "[#{inbound.list.name}:#{inbound.number}] #{inbound.subject}"
        m.from = inbound.from
        m.from_name = inbound.sender.name
        m.to = "#{inbound.sender.name} <#{inbound.from}>"
        m.bcc = inbound.list.to
        m.reply_to = inbound.from
      end

      message.instance_variable_set(:@headers, message.headers.merge("List-Id" => inbound.list.header_id))

      inbound.attachments.each do |attachment|
        message.attachments << {
          file: Faraday::UploadIO.new(
            Base64.decode64(attachment.content_base64),
            attachment.mime,
            attachment.name
          ),
          name: attachment.name
        }
      end

      send_message!(message)
    end

    def notify!(notification)
      message = SendGrid::Mail.new do |m|
        m.text = <<-EOT.strip_heredoc
          投稿エラー
          #{notification[:cause]}、メッセージの投稿に失敗しました。
          #{notification[:deal]}。

          ※このメールはメーリングリストシステムによる自動送信です。
          不明な点は管理者にお問い合わせください。
          このメールに返信すると、管理者に転送されます。

          元のメッセージ
          ==============
          件名： #{notification[:original_message].subject || "無題"}
          #{notification[:original_message].text}
        EOT
        m.subject = notification[:original_message].subject
        m.from = ENV["ML_ADMIN_EMAIL"]
        m.from_name = ENV["ML_ADMIN_NAME"]
        m.to = notification[:original_message].from
      end

      send_message!(message)
    end

    def send_message!(message)
      @@client.send(message)
    end
  end
end
