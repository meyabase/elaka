class FlagsController < ApplicationController
  before_action :set_report, only: [:destroy]
  before_action :set_paper_trail_whodunnit, only: [:destroy]

  def index
    @entries = Entry.where('reports_count > ?', 0).order(created_at: :desc).page params[:page]
  end

  def show
  end

  def destroy
  end

  def get_reports(entry)
    @reports = entry.reports
  end

  def get_user(user_id)
    @user = User.find_by(id: user_id)
  end

  # also same method in profiles_controller.rb and entries_controller.rb
  def get_verified(entry)
    @vote = (entry.get_likes :vote_scope => 'verify').first
    if @vote
      @user = User.find_by(id: @vote.voter_id)
    end
  end

  helper_method :get_reports, :get_user, :get_verified

  private

  def set_report
    @report = Report.friendly.find(params[:id])
  end

  def set_entry
    @entry = Entry.friendly.find(params[:id])
  end

end
