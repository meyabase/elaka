class ConfirmationsController < Devise::ConfirmationsController
  skip_before_action :verify_authenticity_token
  after_action :after_confirmation_path_for
  #protect_from_forgery

  private
  def after_confirmation_path_for(resource_name, resource)
    sign_in(resource)
    root_path
  end
end