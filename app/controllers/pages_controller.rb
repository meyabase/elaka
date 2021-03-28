class PagesController < ApplicationController
  before_action :require_username

  def search
    custom_meta_tags('Search translations',
                     "Looking for a translation? Search Elaka translations and get instant results.",
                     %w[search look find learn oshiwambo])

    @search = Entry.ransack(params[:q])
    @search.sorts = 'created_at desc' if @search.sorts.empty?
    @entries = @search.result.page params[:page]
  end

  def trending
    custom_meta_tags('Trending translations',
                     "Keep up with hot and trending translation. Learn with everyone.",
                     %w[trending hot learn oshiwambo])

    @trends = Entry.where(created_at: 24.hours.ago..Time.now)
    @trends = @trends.order(cached_scoped_vote_votes_up: :desc).page params[:page]
  end

  def users
    custom_meta_tags('Users',
                     "Find a user by their username",
                     %w[user username learn oshiwambo])

    @search = User.ransack(params[:q])
    @search.sorts = 'entries_count desc' if @search.sorts.empty?
    @users = @search.result.page params[:page]
  end

  def verify
    custom_meta_tags('Verify Translations',
                     "Read through a list of all unverified translations and mark them valid",
                     %w[verify mark valid learn oshiwambo])

    @entries = Entry.where(cached_scoped_verify_votes_up: 0)
    @entries = @entries.order(created_at: :desc).page params[:page]
  end

  def about
    custom_meta_tags('About Elaka',
                     "Our goal is to contribute to effective communication, aid in the
                      transmission of Knowledge, preserve cultural heritage,
                      accelerate education and more",
                     %w[about why us learn oshiwambo])
    @general = User.where(moderator: false).order(Arel.sql('RANDOM()')).first
    @moderator = User.where(moderator: true).order(Arel.sql('RANDOM()')).first
  end

  def privacy
    custom_meta_tags('Elaka Privacy',
                     "What your privacy rights are and how you can exercise them.",
                     %w[privacy rights learn oshiwambo])
  end

  def terms
    custom_meta_tags('Elaka Terms of Service',
                     "What your terms of service include and how you can exercise them.",
                     %w[terms service conditions learn oshiwambo])
  end

  def guidelines
    custom_meta_tags('Elaka Guidelines',
                     "Elaka is made by a community of numerous individuals,
                      including you. Anybody can post a translation, but in order to
                      keep things fun for everyone, we ask that you follow a few ground rules.",
                     %w[guidelines learn oshiwambo])
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
