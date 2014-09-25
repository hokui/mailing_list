class InboundsController < Api::ApplicationController
  def create
    messages = JSON.parse(params["mandrill_events"]).map { |e| e["msg"] }

    messages.each do |message|
      unless sender = Member.find_from_existing_emails(message["from_email"])
        # ErrorNotifier.unknown_sender(message).deliver
        head 200
        return
      end

      unless list = List.find_by(name: message["email"].split("@").first)
        # ErrorNotifier.unknown_list(message).deliver
        head 200
        return
      end

    end
  end
end
