class Inbound
  attr_reader :from, :sender, :list, :parent, :number, :subject, :text, :html, :raw, :images, :attachments

  def initialize(params)
    @from = JSON.parse(params["envelope"])["from"]
    @sender = Member.find_from_existing_emails(@from)
    @list = List.find_by(name: params["to"].split("@").first)
    @number = @list.next_number
    @subject = params["subject"] || "無題"
    @text = params["text"]
    @html = params["html"]
    @parent = nil
    @raw = nil

    @attachments = build_attachments(params) || []
  end

  def save_archive!
    fail "UnknownSender" unless @sender
    fail "UnknownList" unless @list
    fail "NotParticipating" unless @sender.lists.include?(@list)

    @archive = Archive.new(
      list: @list,
      parent: @parent,
      number: @number,
      from: @from,
      subject: @subject,
      text: @text,
      html: @html || "",
      raw: @raw || "dummy raw"
    )
    begin
      @archive.save!
      @attachments.each do |attachment|
        attachment.archive = @archive
        attachment.save!
      end
    rescue ActiveRecord::RecordInvalid
      fail "InvalidMessage"
    end

    self
  end

  def publish!
    begin
      SendGridClient.publish!(self)
    rescue
      fail "FailedPublication"
    end
  end

  private

  def build_attachments(params)
    return if params["attachment-info"].nil?

    JSON.parse(params["attachment-info"]).map do |k, v|
      Attachment.new(
        name: v["filename"],
        mime: v["type"],
        is_image: false,
        content_base64: Base64.encode64(params[k].read)
      )
    end
  end
end
