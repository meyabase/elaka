class RegistrationsController < Devise::RegistrationsController
  # Check this out in case you'd need it some days
  # https://www.semicolonworld.com/question/75050/how-to-ldquo-soft-delete-rdquo-user-with-devise

  before_action :release_entries, only: :destroy

  def release_entries
    kalipi = User.find_by(username: 'kalipi')
    Entry.where(user_id: current_user.id).update_all(:user_id => kalipi.id)
  end
end