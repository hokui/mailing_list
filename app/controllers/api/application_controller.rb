class Api::ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  before_action :authenticate

  private

  def authenticate
    authenticate_or_request_with_http_basic do |user, pass|
      user == ENV["HTTP_USER"] && pass = ENV["HTTP_PASS"]
    end
  end
end
