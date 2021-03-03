class ConfirmationsController < Devise::ConfirmationsController
  protect_from_forgery

  private
  def after_confirmation_path_for(resource_name, resource)
    sign_in(resource)
    root_path
  end
end