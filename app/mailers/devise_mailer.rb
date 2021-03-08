class DeviseMailer < Devise::Mailer
  helper :application
  include Devise::Controllers::UrlHelpers
  layout 'mailer'
  require 'mailgun-ruby'

  def confirmation_instructions(record, token, opts={})
    @user = record
    @token = token
    mg_client = Mailgun::Client.new ENV["MAILGUN_API_KEY"]
    output = render_to_string template: "devise/mailer/confirmation_instructions"
    message_params = {:from => "Elaka <#{ ENV["DUMMY_SENDER_EMAIL"] }>", :to => @user.email,
                      :subject => "Verify your Elaka email address",
                      :html => output.to_str }
    mg_client.send_message ENV["MAILGUN_DOMAIN"], message_params
  end

  def reset_password_instructions(record, token, opts={})
    @user = record
    @token = token
    mg_client = Mailgun::Client.new ENV["MAILGUN_API_KEY"]
    output = render_to_string template: "devise/mailer/reset_password_instructions"
    message_params = {:from => "Elaka <#{ ENV["DUMMY_SENDER_EMAIL"] }>", :to => @user.email,
                      :subject => "Reset your Elaka password",
                      :html => output.to_str }
    mg_client.send_message ENV["MAILGUN_DOMAIN"], message_params
  end

  def unlock_instructions(record, token, opts={})
    @user = record
    @token = token
    mg_client = Mailgun::Client.new ENV["MAILGUN_API_KEY"]
    output = render_to_string template: "devise/mailer/unlock_instructions"
    message_params = {:from => "Elaka <#{ ENV["DUMMY_SENDER_EMAIL"] }>", :to => @user.email,
                      :subject => "Unlock your Elaka account",
                      :html => output.to_str }
    mg_client.send_message ENV["MAILGUN_DOMAIN"], message_params
  end

  def email_changed(record, opts={})
    @user = record
    mg_client = Mailgun::Client.new ENV["MAILGUN_API_KEY"]
    output = render_to_string template: "devise/mailer/email_changed"
    message_params = {:from => "Elaka <#{ ENV["DUMMY_SENDER_EMAIL"] }>", :to => @user.email,
                      :subject => "Your Elaka email changed",
                      :html => output.to_str }
    mg_client.send_message ENV["MAILGUN_DOMAIN"], message_params
  end

  def password_change(record, opts={})
    @user = record
    mg_client = Mailgun::Client.new ENV["MAILGUN_API_KEY"]
    output = render_to_string template: "devise/mailer/password_change"
    message_params = {:from => "Elaka <#{ ENV["DUMMY_SENDER_EMAIL"] }>", :to => @user.email,
                      :subject => "Your Elaka password changed",
                      :html => output.to_str }
    mg_client.send_message ENV["MAILGUN_DOMAIN"], message_params
  end
end