class PagesController < ApplicationController

  def search
    @search = Entry.ransack(params[:q])
    @search.sorts = 'created_at desc' if @search.sorts.empty?
    @entries = @search.result.page params[:page]
  end

  def trending
    @trends = Entry.where(created_at: 24.hours.ago..Time.now)
    @trends = @trends.order(cached_scoped_vote_votes_up: :desc).page params[:page]
  end

  def users
    @search = User.ransack(params[:q])
    @search.sorts = 'entries_count desc' if @search.sorts.empty?
    @users = @search.result.page params[:page]
  end

  def about
  end

  def privacy
  end

  def terms
  end

  def guidelines
  end

  # also same method in profiles_controller.rb and entries_controller.rb
  def get_verified(entry)
    @vote = (entry.get_likes :vote_scope => 'verify').first
    if @vote
      @user = User.find_by(id: @vote.voter_id)
    end
  end
  helper_method :get_verified, :hot

end
