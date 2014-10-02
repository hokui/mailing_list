class Inbound
  class UnknownSenderError     < StandardError; end
  class UnknwonListError       < StandardError; end
  class InvalidMessageError    < StandardError; end
  class FailedPublicationError < StandardError; end

  def initialize(message)
    @sender, @from = Member.find_from_existing_emails(message["from_email"])
    unless @sender
      raise UnknownSenderError
    end
    unless @list = List.find_by(name: message["email"].split("@").first)
      raise UnknwonListError
    end

    @number = @list.next_number
    @subject = "[#{@list.name}:#{@number}] #{message["subject"] || "無題"}"
    @text = message["text"]
    @html = message["html"]
    @raw = message["raw_msg"]

    # TODO Attachments, Pics, Emoji, Env-dep chars, etc.
  end

  def save_archive!
    begin
      Archive.create!(
        list: @list,
        number: @number,
        from: @from,
        subject: @subject,
        text: @text,
        html: @html,
        raw: @raw
      )
    rescue ActiveRecord::RecordInvalid
      raise InvalidMessageError
    end

    self
  end

  def publish!
    # WIP

    # TODO if hourly_quota is insufficient, notify sender
  end
end