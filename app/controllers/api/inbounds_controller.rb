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
          Notifier.unknown_sender(message).deliver
        when "UnknownList"
          Notifier.unknown_list(message).deliver
        when "NotParticipating"
          Notifier.not_participating(message).deliver
        when "InvalidMessage"
          Notifier.invalid_message(message).deliver
        when "FailedPublication"
          Notifier.failed_publication(message).deliver
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
