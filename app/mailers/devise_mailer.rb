# https://github.com/plataformatec/devise/wiki/How-To:-Use-custom-mailer
# https://stackoverflow.com/questions/17002994/how-do-i-set-a-custom-email-subject-in-a-custom-devise-email
# Not Working lol. Just edit the config/locales/devise.en.yml
class DeviseMailer < Devise::Mailer
  helper :application
  include Devise::Controllers::UrlHelpers
  default template_path: 'devise/mailer'

  #def confirmation_instructions(record, token, opts={})
  # opts[:subject] = "Verify your Elaka email address"
  # attachments.inline['logo512Black.png'] = File.read("app/assets/images/logo512Black.png")
  # super
  #end
end