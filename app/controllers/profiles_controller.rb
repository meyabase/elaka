class ProfilesController < ApplicationController
  before_action :set_user

  def show
    if @user
      @entries = @user.entries.order(created_at: :desc).page params[:page]
    end
  end

  def votes
    @entries = (@user.get_voted Entry, :vote_scope => 'vote').page params[:page]
  end

  def saved
    @entries = (@user.get_voted Entry, :vote_scope => 'saved').page params[:page]
  end

  def verified
    @entries = (@user.get_voted Entry, :vote_scope => 'verify').page params[:page]
  end

  private

  def set_user
    @user = User.find_by(username: params[:username])
  end
end
