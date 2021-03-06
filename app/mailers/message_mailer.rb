class MessageMailer < ApplicationMailer
  require 'mailgun-ruby'

  def contact(message)
    mg_client = Mailgun::Client.new ENV["MAILGUN_API_KEY"]
    message_params = {:from => "Axel <#{ message.email }>",
                      :to => ENV["DEFAULT_EMAIL"],
                      :subject => 'Elaka Form: ' + message.subject ,
                      :text => message.content}
    mg_client.send_message ENV["MAILGUN_DOMAIN"], message_params
  end
end