class Entry < ApplicationRecord
  # https://github.com/norman/friendly_id
  extend FriendlyId
  friendly_id :link
  acts_as_votable cacheable_strategy: :update_columns
  paginates_per 15
  has_paper_trail

  # https://guides.rubyonrails.org/association_basics.html#options-for-belongs-to-counter-cache
  belongs_to :user, counter_cache: true
  has_many :reports, dependent: :destroy
  accepts_nested_attributes_for :reports

  validates_presence_of :user_id

  validates :translation, presence: { message: "Translation type is missing!"}

  validates :from,
            presence: { message: "can't be empty"},
            format: { with: /\A[a-zA-Z,.?!'‘`’\-\s]*\z/, message: "text contains invalid character(s)"}

  validates :to,
            presence: { message: "can't be empty"},
            format: { with: /\A[a-zA-Z,.?!'‘`’\-\s]*\z/, message: "text contains invalid character(s)"}

  # Only validate using scopes on update. This is due to some filtering requirements for the model Entry
  validates :from, uniqueness: { scope: [ :to, :language ], message: 'translation already exists.' }#, on: :update
  validates :to, uniqueness: { scope: [ :from, :language ], message: 'translation already exists.' }#, on: :update

  # Only validate using the specified method on create
  validate :entry_uniqueness, on: :create

  private

  def entry_uniqueness
    if Entry.where('"language" = ? AND "from" = ? AND "to" = ?',
                   language, from.downcase, to.downcase).exists?
      errors.add(:base, 'Identical translation already exists.')

    elsif Entry.where('"language" = ? AND "to" = ? AND "from" = ?',
                      language, from.downcase, to.downcase).exists?
      errors.add(:base, 'Reverse identical translation already exists.')
    end
  end
end
