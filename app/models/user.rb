class User < ApplicationRecord
  attr_writer :login

  extend FriendlyId
  friendly_id :username
  acts_as_voter
  paginates_per 15
  has_paper_trail

  has_many :entries
  has_many :reports, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  # remove ability to send email confirmation and password reset links etc when in development mode
  if Rails.env.production?
    devise :database_authenticatable, :registerable, :confirmable,
           :recoverable, :rememberable, :validatable,
           authentication_keys: [:login]
  else
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable,
           authentication_keys: [:login]
  end


  validates :email,
            presence: { message: "can't be empty"},
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
                      message: "is of incorrect format " },
            :uniqueness =>  {:case_sensitive => false}

  validates :username,
            on: :update,
            presence: { message: "can't be empty"},
            format: { with: /^[a-zA-Z0-9_]*$/,
                      :multiline => true,
                      message: "is of incorrect format " },
            :uniqueness =>  {:case_sensitive => false},
            length: { minimum: 3, maximum: 15 },
            exclusion: { in: %w(admin administrator anonymous elaka oshiwambo english
                                oshikwanyama oshindonga language about account root etc
                                wwww moderator verified superadmin supervisor user privacy
                                terms about search reports entry entries post report profile
                                profiles translation translate home post signup signin logout
                                login register join registration hot),
                         message: "%{value} is reserved." }

  before_create :downcase_email
  before_update :downcase_email, :downcase_username

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication warden_condition
    conditions = warden_condition.dup
    login = conditions.delete(:login)
    where(conditions).where(
      ["lower(username) = :value OR lower(email) = :value",
       { value: login.strip.downcase}]).first
  end

  def downcase_email
    self.email = self.email.downcase
  end

  def downcase_username
    if username
      self.username = self.username.downcase
    end
  end
end
