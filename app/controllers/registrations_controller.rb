class RegistrationsController < Devise::RegistrationsController
  # Check this out in case you'd need it some days
  # https://www.semicolonworld.com/question/75050/how-to-ldquo-soft-delete-rdquo-user-with-devise
  before_action :release_entries, only: :destroy

  def new
    custom_meta_tags('Sign up to create your account',
                     'Join Learn Oshiwambo and contribute now',
                     %w[sign-up signup join register create])

    build_resource
    yield resource if block_given?
    respond_with resource
  end

  def edit
    custom_meta_tags('Edit your account',
                     'Edit and update your Elaka account',
                     %w[edit profile edit_account details])

    render :edit
  end

  def release_entries
    if current_user.username != 'kalipi'
      kalipi = User.find_by(username: 'kalipi')
      Entry.where(user_id: current_user.id).update_all(:user_id => kalipi.id)
    else
      flash[:error] = "Cannot remove default user! Contact SuperUser!"
    end
  end

  protected

  def update_resource(resource, params)
   if user_signed_in? and current_user.username == ""
     resource.update_without_password(params)
   else
     resource.update_with_password(params)
   end
  end

  private

  def username_params
    params.require(:user).permit(:username)
  end

end