class Inbound
  attr_reader :from, :sender, :list, :subject, :text, :html, :raw, :images, :attachments

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

    @message_id = message["headers"]["Message-Id"]

    if parent_message_id = message["headers"]["In-Reply-To"]
      @parent = Archive.find_by(message_id: parent_message_id)
    end

    @number = @list.next_number
    @subject = message["subject"] || "無題"
    @text = message["text"]
    @html = message["html"]
    @raw = message["raw_msg"]

    @images      = build_attachments(message["images"], true)
    @attachments = build_attachments(message["attachments"], false)

    # TODO: Consider "In-Reply-To"
  end

  def save_archive!
    begin
      archive = Archive.create!(
        list: @list,
        parent: @parent,
        message_id: @message_id,
        number: @number,
        from: @from,
        subject: @subject,
        text: @text,
        html: @html || "",
        raw: @raw
      )
      (@images + @attachments).each do |attachment|
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

  def build_attachments(hash, is_image)
    attachments = Array.new

    return attachments if hash.nil?

    hash.each do |k, v|
      if v["base64"] == false
        content_base64 = Base64.encode64(v["content"])
      else
        content_base64 = v["content"]
      end

      # TODO get original filename for images

      attachments << Attachment.new(
        name: v["name"],
        mime: v["type"],
        is_image: is_image,
        content_base64: content_base64
      )
    end

    attachments
  end
end
