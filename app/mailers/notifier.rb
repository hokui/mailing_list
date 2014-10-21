class Notifier
  def deliver
    MandrillApp.new.send_message!(@notification)
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

  private

  def build_notification(cause, deal, message)
    notification = {}
    notification[:text] = <<-EOT.strip_heredoc
      投稿エラー
      #{cause}、メッセージの投稿に失敗しました。
      #{deal}。

      ※このメールはメーリングリストシステムによる自動送信です。
      不明な点は管理者にお問い合わせください。
      このメールに返信すると、管理者に転送されます。

      元のメッセージ
      ==============
      件名： #{message["subject"] || "無題"}
      #{message["text"]}
    EOT
    notification[:subject] = message["subject"]
    notification[:from_email] = ENV["ML_ADMIN_EMAIL"]
    notification[:from_name] = ENV["ML_AMIN_NAME"]
    notification[:to] = message["from_email"]
    notification[:headers] = { "In-Reply-To" => message["headers"]["Message-Id"] }
    notification[:important] = true
    notification[:track_opens] = true

    notification
  end
end
