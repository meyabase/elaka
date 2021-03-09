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

  private

  def set_report
    @report = Report.friendly.find(params[:id])
  end

  def set_entry
    @entry = Entry.friendly.find(params[:id])
  end

end
