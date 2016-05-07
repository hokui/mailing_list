class Notifier
  def deliver
    SendGridClient.notify!(@notification)
  end

  def unknown_sender(message)
    cause = "あなたのアドレスが北医ネットに登録されていないため"
    deal = "登録済みのアドレスから、再度お試しください。"
    @notification = build_notification(cause, deal, message)

    self
  end

  def unknown_list(message)
    cause = "宛先アドレスのメーリングリスト・グループを見つけられなかったため"
    deal = "アドレスを確認し、再度お試しください。"
    @notification = build_notification(cause, deal, message)

    self
  end

  def not_participating(message)
    cause = "指定されたグループに参加していないため"
    deal = "登録済みのアドレスから、再度お試しください"
    @notification = build_notification(cause, deal, message)

    self
  end

  def invalid_message(message)
    cause = "メッセージを正常に処理できなかったため"
    deal = "管理者に報告しましたので、しばらくお待ちください"
    @notification = build_notification(cause, deal, message)

    self
  end

  def failed_publication(message)
    cause = "外部サービスエラーのため"
    deal = "管理者に報告しましたので、しばらくお待ちください"
    @notification = build_notification(cause, deal, message)

    self
  end

  def insufficient_hourly_quota(message)
    cause = "時間あたりの送信量制限に達したため"
    deal = "メッセージは1時間以内に配信されますので、そのままお待ちください。"
    @notification = build_notification(cause, deal, message)

    self
  end

  private

  def build_notification(cause, deal, original_message)
    {
      cause: cause,
      deal: deal,
      original_message: original_message
    }
  end
end
