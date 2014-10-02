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
    # WIP
  end

  private

  def post_body(options={})
    options.merge({ key: @api_key }).to_json
  end
end
