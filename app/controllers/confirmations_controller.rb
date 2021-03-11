class ConfirmationsController < Devise::ConfirmationsController
  skip_before_action :verify_authenticity_token

  def show
    super do
      sign_in(resource) if resource.errors.empty?
    end
  end

  private

  def after_confirmation_path_for(resource_name, resource)
    require_username
  end
end