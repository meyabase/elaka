require 'net/https'
class ApplicationController < ActionController::Base
  RECAPTCHA_MINIMUM_SCORE = 0.5
  before_action :configure_permitted_parameters, if: :devise_controller?

  def get_reports(entry)
    @reports = entry.reports
  end

  def get_user(user_id)
    @user = User.find_by(id: user_id)
  end

  def get_verified(entry)
    @vote = (entry.get_likes :vote_scope => 'verify').first
    if @vote
      @user = User.find_by(id: @vote.voter_id)
    end
  end

  helper_method :get_reports, :get_user, :get_verified

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  helper_method :resource_name, :resource, :devise_mapping, :resource_class

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def resource_class
    User
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  private

  def require_username
    if user_signed_in? and current_user.username == ""
      flash[:alert] = "Set up username to continue"
      redirect_to edit_user_registration_path
    end
  end

  def custom_meta_tags(title, description, keywords)
    @page_title = title
    @page_description = description
    @page_keywords = keywords
  end

end
