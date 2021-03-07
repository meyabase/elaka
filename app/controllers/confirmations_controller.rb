class ConfirmationsController < Devise::ConfirmationsController
  skip_before_action :verify_authenticity_token
  #protect_from_forgery

  private

  def after_confirmation_path_for(resource_name, resource)
    sign_in(resource)
    root_path
  end
end