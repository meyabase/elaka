class FlagsController < ApplicationController
  before_action :require_username

  def index
    custom_meta_tags('Reported Translations',
                     "Here you can find all reported translations
                     that do not meet our guidelines.",
                     %w[reports learn oshiwambo elaka reported wrong])

    @entries = Entry.where('reports_count > ?', 0).order(created_at: :desc).page params[:page]
  end

  private

  def set_report
    @report = Report.friendly.find(params[:id])
  end

  def set_entry
    @entry = Entry.friendly.find(params[:id])
  end

end
