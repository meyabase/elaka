class EntriesController < ApplicationController
  before_action :set_entry, except: [:new, :create, :index]
  before_action :authenticate_user!, except: [:new, :create, :index, :show]
  before_action :set_paper_trail_whodunnit, only: [:create, :destroy, :update]
  before_action :kalipi_sign_in, only: :create
  after_action :kalipi_sign_out, only: :create
  before_action :require_username
  invisible_captcha only: [:create]

  def new
    custom_meta_tags('Create translation',
                     'Create a new, unique and interesting translation from English to Oshiwambo
                                and be part of Elaka.',
                     %w[create new post translate learn oshiwambo])

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

      # temporary for the competition
      # if @entry.created_at >= DateTime.parse("2021-04-27 22:00:00")
      #  count = current_user.competition
      # unless count
      #   count = 0
      # end
      # count += 1
      # current_user.update_column(:competition, count)
      # end

      redirect_to new_entry_path
    else
      flash.now[:error] = @entry.errors.full_messages[0]
      render :new
    end
  end

  def index
    custom_meta_tags('Translations',
                     'Learn Oshiwambo is where numerous community members shape the future of Oshiwambo
                                language, together. Contribute to the open source community, manage your translation
                                entries, educate others',
                     %w[learn oshiwambo elaka Translations timeline feed newsfeed all updated])

    @entries = Entry.order(created_at: :desc).page params[:page]
  end

  def show
    from_value = @entry.from.split
    to_value = @entry.to.split

    custom_meta_tags("@#{ @entry.user.username } on Elaka:
                            #{ @entry.from.chars.first(10).join } translates to
                            #{ @entry.to.chars.first(10).join }",
                     "#{ @entry.from } translates to #{ @entry.to }",
                     from_value + to_value + %w[Translation translate learn oshiwambo])
    @reports = @entry.reports
  end

  def edit
    from_value = @entry.from.split
    to_value = @entry.to.split

    custom_meta_tags("Edit translation: #{ @entry.from.chars.first(10).join } ->
                            #{ @entry.to.chars.first(10).join }",
                     "#{ @entry.from } -> #{ @entry.to }",
                     from_value + to_value + %w[edit update learn oshiwambo])
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
