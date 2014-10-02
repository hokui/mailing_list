class Api::InboundsController < Api::ApplicationController
  def create
    messages = JSON.parse(params["mandrill_events"]).map { |e| e["msg"] }

    messages.each do |message|
      begin
        Inbound.new(message).save_archive!.publish!
      rescue Inbound::UnknownSenderError
        # ErrorNotifier.unknown_sender(message).deliver
      rescue Inbound::UnknownListError
        # ErrorNotifier.unknown_list(message).deliver
      rescue Inbound::InvalidMessageError
        # ErrorNotifier.invalid_message(message).deliver
      rescue Inbound::FailedPublicationError
        # ErrorNotifier.failed_publication(message).deliver
      end

      head 200
      return
    end
  end
end
