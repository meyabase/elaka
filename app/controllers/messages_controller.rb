class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = Message.new message_params

    unless verify_recaptcha?(params[:recaptcha_token], 'message')
      flash.now[:error] = t('recaptcha.errors.verification_failed')
      return render :new
    end

    if @message.valid?
      MessageMailer.contact(@message).deliver_now
      redirect_to new_message_url
      flash[:notice] = "We have received your message and will be in touch soon!"
    else
      flash[:error] = "There was an error sending your message. Please try again."
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit(:name, :email, :subject, :content)
  end
end
