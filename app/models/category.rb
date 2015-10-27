class Category < ActiveRecord::Base
  # Validations ----------------------------------------------------------------
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  # Associations ---------------------------------------------------------------
  belongs_to :categorizable, polymorphic: true
  has_many :category_joins
  has_many :broadcasts, through: :category_joins, source: :categorizable,
    source_type: 'Broadcast'
  has_many :lectures, through: :category_joins, source: :categorizable,
    source_type: 'GuestLecture'
  has_many :notes, through: :category_joins, source: :categorizable,
    source_type: 'Note'
  has_many :users, through: :category_joins, source: :categorizable,
    source_type: 'User'

  # Scopes ---------------------------------------------------------------------
  scope :alphabetized, -> { order(:name) }
  scope :not_admin, -> { where(admin_only: false) }
  scope :admin, -> { where(admin_only: true) }
  scope :visible, -> { where(hidden: false).where(approved: true).alphabetized }
  scope :tags, -> { where(user_related: true) }
  scope :topics, -> { where(topic_related: true) }
  scope :any_user, -> { visible.not_admin }
  scope :any_user_tags, -> { any_user.tags }
  scope :any_user_topics, -> { any_user.topics }
end
