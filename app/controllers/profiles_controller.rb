class ProfilesController < ApplicationController
  before_action :set_user
  before_action :require_username

  def show
    if @user
      custom_meta_tags("@#{ @user.username }'s Timeline",
                       "Translations created by @#{ @user.username }.",
                       ["#{ @user.username }", "learn", "oshiwambo"])

      @count = Entry.count
      @entries = @user.entries.order(created_at: :desc).page params[:page]
    end
  end

  def votes
    custom_meta_tags("@#{ @user.username }'s Votes",
                     "Translations voted by @#{ @user.username }.",
                     ["#{ @user.username }", "votes", "learn", "oshiwambo"])

    @count = Entry.count
    @entries = (@user.get_voted Entry, :vote_scope => 'vote').page params[:page]
  end

  def saved
    custom_meta_tags("@#{ @user.username }'s Bookmarks",
                     "Translations created by @#{ @user.username }.",
                     ["#{ @user.username }", "saved", "bookmarks", "learn", "oshiwambo"])

    @count = Entry.count
    @entries = (@user.get_voted Entry, :vote_scope => 'saved').page params[:page]
  end

  def verified
    custom_meta_tags("@#{ @user.username }'s Verified",
                     "Translations verified by @#{ @user.username }.",
                     ["#{ @user.username }", "verified", "learn", "oshiwambo"])

    @count = Entry.count
    @entries = (@user.get_voted Entry, :vote_scope => 'verify').page params[:page]
  end

  private

  def set_user
    @user = User.find_by(username: params[:username])
  end
end
