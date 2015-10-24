class Category < ActiveRecord::Base
  # Validations ----------------------------------------------------------------
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  # Associations ---------------------------------------------------------------
  belongs_to :categorizable, polymorphic: true
  has_many :category_joins
  has_many :notes, through: :category_joins, source: :categorizable,
    source_type: 'Note'
  has_many :broadcasts, through: :category_joins, source: :categorizable,
    source_type: 'Broadcast'
  has_many :users, through: :category_joins, source: :categorizable,
    source_type: 'User'
  has_many :lectures, through: :category_joins, source: :categorizable,
    source_type: 'GuestLecture'

  # Scopes ---------------------------------------------------------------------
  scope :alphabetized, -> { order(:name) }
  scope :admin, -> { alphabetized.where(admin_only: true) }
  scope :visible, -> { where(hidden: false).where(approved: true).alphabetized }
  scope :any_user, -> { visible.where(admin_only: false) }
end
