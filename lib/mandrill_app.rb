class MandrillApp
  include HTTParty
  base_uri "mandrillapp.com"

  def initialize
    @api_key = ENV["MANDRILL_KEY"]
  end

  def user_info
    self.class.post("/api/1.0/users/info.json", body: post_body)
  end

  def send_message(message)
    self.class.post("/api/1.0/messages/send.json", body: post_body({ message: message }))
  end

  def publish(inbound)
    message = {}
    message[:html] = inbound.html if inbound.html.length > 0
    message[:text] = inbound.text
    message[:subject] = inbound.subject
    message[:from_email] = inbound.from
    message[:from_name] = inbound.sender.name
    message[:to] = inbound.list.to
    message[:headers] = { "Reply-To" => inbound.from, "List-Id" => inbound.list.header_id }
    message[:important] = true
    message[:track_opens] = true
    message[:preserve_recipients] = false

    send_message(message)
  end

  private

  def post_body(options={})
    options.merge({ key: @api_key }).to_json
  end
end
