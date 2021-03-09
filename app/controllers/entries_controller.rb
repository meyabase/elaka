class EntriesController < ApplicationController
  before_action :set_entry, except: [:new, :create, :index]
  before_action :authenticate_user!, except: [:new, :create, :index, :show]
  before_action :set_paper_trail_whodunnit, only: [:create, :destroy, :update]
  before_action :kalipi_sign_in, only: :create
  after_action :kalipi_sign_out, only: :create
  invisible_captcha only: [:create]

  def new
    @entry = Entry.new
    @kalipi = User.find_by(username: "kalipi")
  end

  def create
    @entry = current_user.entries.build(entry_params)

    if @entry.valid?
      @entry.save
      flash[:notice] = "Your translation was posted."

      # for anonymous id routing, update :link based on id
      @entry.update_column(:link, ((@entry.id**3).to_s(36)))
      redirect_to new_entry_path
    else
      flash.now[:error] = @entry.errors.full_messages[0]
      render :new
    end
  end

  def index
    @entries = Entry.order(created_at: :desc).page params[:page]
  end

  def show
    @reports = @entry.reports
  end

  def update
    if @entry.valid?
      @entry.update(entry_params)
      flash[:notice] = "Translation was updated."
      redirect_to(entry_path(@entry))
    else
      flash.now[:error] = @entry.errors.full_messages[0]
      render :edit
    end
  end

  def destroy
    @entry.destroy
  end

  def upvote
    @entry.liked_by current_user, :vote_scope => 'vote'
  end

  def unupvote
    @entry.unliked_by current_user, :vote_scope => 'vote'
  end

  def downvote
    @entry.disliked_by current_user, :vote_scope => 'vote'
  end

  def undownvote
    @entry.undisliked_by current_user, :vote_scope => 'vote'
  end

  def save_entry
    @entry.liked_by current_user, :vote_scope => 'saved'
  end

  def unsave_entry
    @entry.unliked_by current_user, :vote_scope => 'saved'
  end

  def verify
    @entry.liked_by current_user, :vote_scope => 'verify'
  end

  def unverify
    @entry.unliked_by current_user, :vote_scope => 'verify'
  end

  private

  def set_entry
    @entry = Entry.friendly.find(params[:id])
  end

  # parameters include user_id
  def entry_params
    params.require(:entry).permit(:translation, :from, :to, :language, user: current_user)
  end

  # manage default user kalipi when no one else is signed in
  def kalipi_sign_in
    unless signed_in?
      sign_in(User.find_by(username: 'kalipi'))
    end
  end

  def kalipi_sign_out
    if current_user.username == 'kalipi'
      sign_out(current_user)
    end
  end
end
