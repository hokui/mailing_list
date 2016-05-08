class Api::InboundsController < Api::ApplicationController
  def create
    @inbound = Inbound.new(params)
    begin
      @inbound.save_archive!.publish!
    rescue => e
      logger.error e
      case e.message
      when "UnknownSender"
        Notifier.new.unknown_sender(@inbound).deliver
      when "UnknownList"
        Notifier.new.unknown_list(@inbound).deliver
      when "NotParticipating"
        Notifier.new.not_participating(@inbound).deliver
      when "InvalidMessage"
        Notifier.new.invalid_message(@inbound).deliver
      when "FailedPublication"
        Notifier.new.failed_publication(@inbound).deliver
      else
        raise
      end
    ensure
      head 200
    end
  end
end
