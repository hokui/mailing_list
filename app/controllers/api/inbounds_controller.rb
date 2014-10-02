class Api::InboundsController < Api::ApplicationController
  def create
    messages = JSON.parse(params["mandrill_events"]).map { |e| e["msg"] }

    messages.each do |message|
      begin
        Inbound.new(message).save_archive!.publish!
      rescue => e
        logger.error e
        case e.message
        when "UnknownSender"
          # ErrorNotifier.unknown_sender(message).deliver
        when "UnknownList"
          # ErrorNotifier.unknown_list(message).deliver
        when "InvalidMessage"
          # ErrorNotifier.invalid_message(message).deliver
        when "FailedPublication"
          # ErrorNotifier.failed_publication(message).deliver
        else
          raise
        end
      ensure
        head 200
        return
      end
    end
  end
end
