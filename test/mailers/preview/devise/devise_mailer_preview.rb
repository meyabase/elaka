class Devise::MailerPreview < ActionMailer::Preview

  def confirmation_instructions
    Devise::Mailer.confirmation_instructions(User.first)
  end

end