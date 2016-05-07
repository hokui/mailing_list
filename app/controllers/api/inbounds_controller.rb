class Api::InboundsController < Api::ApplicationController
  def create
    begin
      Inbound.new(params).save_archive!.publish!
    rescue => e
      logger.error e
      case e.message
      when "UnknownSender"
        Notifier.new.unknown_sender(message).deliver
      when "UnknownList"
        Notifier.new.unknown_list(message).deliver
      when "NotParticipating"
        Notifier.new.not_participating(message).deliver
      when "InvalidMessage"
        Notifier.new.invalid_message(message).deliver
      when "FailedPublication"
        Notifier.new.failed_publication(message).deliver
      else
        raise
      end
    ensure
      head 200
    end
  end
end
