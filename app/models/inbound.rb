class Inbound
  attr_reader :from, :sender, :list, :subject, :text, :html, :raw

  def initialize(message)
    @from = message["from_email"]

    unless @sender = Member.find_from_existing_emails(@from)
      fail "UnknownSender"
    end

    unless @list = List.find_by(name: message["email"].split("@").first)
      fail "UnknownList"
    end

    unless @sender.lists.include?(@list)
      fail "NotParticipating"
    end

    @number = @list.next_number
    @subject = "[#{@list.name}:#{@number}] #{message["subject"] || "無題"}"
    @text = message["text"]
    @html = message["html"]
    @raw = message["raw_msg"]

    @attachments = Array.new
    @attachments += build_attachments(message["images"])
    @attachments += build_attachments(message["attachments"])
  end

  def save_archive!
    begin
      archive = Archive.create!(
        list: @list,
        number: @number,
        from: @from,
        subject: @subject,
        text: @text,
        html: @html || "",
        raw: @raw
      )
      @attachments.each do |attachment|
        attachment.archive = archive
        attachment.save!
      end
    rescue ActiveRecord::RecordInvalid
      fail "InvalidMessage"
    end

    self
  end

  def publish!
    begin
      MandrillApp.new.publish!(self)
    rescue
      fail "FailedPublication"
    end

    # TODO if hourly_quota is insufficient, notify sender
  end

  private

  def build_attachments(hash)
    attachments = Array.new

    return attachments if hash.nil?

    hash.each do |k, v|
      attachments << Attachment.new(
        name: v["name"],
        mime: v["type"],
        content_base64: v["content"]
      )
    end

    attachments
  end
end
