require Rails.root.join('lib/build_constraints_regex')

class User < ActiveRecord::Base
  # Associations ---------------------------------------------------------------
  has_many :oauths
  has_many :guest_lectures
  has_many :notes
  has_many :events
  has_and_belongs_to_many :calendars
  has_many :category_joins, as: :categorizable
  has_many :categories, through: :category_joins
  has_many :broadcasts, through: :categories
  # has_and_belongs_to_many :events

  # Callbacks ------------------------------------------------------------------
  after_create :schedule_welcome_email

  # Validations ----------------------------------------------------------------
  has_secure_password validations: false

  user_types = ["Admin", "Student", "Volunteer"]
  USER_TYPE_CONSTRAINTS = build_contraints_regex(user_types)

  validates_presence_of :name, :email, :type
  validates_format_of :type, with: USER_TYPE_CONSTRAINTS
  validates :name, length: { maximum: 250 }
  validates :email, length: { maximum: 320 }, uniqueness: { case_sensitive: false }
  # validate :has_secure_password_or_has_omniauth # FIXME: this isn't fully tested


  accepts_nested_attributes_for :categories

  private
    def has_secure_password_or_has_omniauth
      validates_confirmation_of :password, unless: self.oauths.any?
      validates_presence_of :password_digest, unless: self.oauths.any?
    end

    def schedule_welcome_email
      # add to list somewhere?
      # cronjob checks every 1 hr & adds new events?
    end
end
