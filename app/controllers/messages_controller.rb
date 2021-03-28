class MessagesController < ApplicationController
  invisible_captcha only: [:create]
  before_action :require_username

  def new
    custom_meta_tags('Help Form',
                     "Do you have any questions, report to make, suggestions or anything to say? Contact us now.",
                     %w[contact help email question enquiry learn oshiwambo])

    @message = Message.new
  end

  def create
    @message = Message.new message_params
    if @message.valid?
      MessageMailer.contact(@message).deliver_now
      redirect_to help_path
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
