class UserMailer < ApplicationMailer
  def account_activation account
    @account = account
    mail to: account.email, subject: t("mailers.user_mailer.sub_active")
  end

  def password_reset; end
end
