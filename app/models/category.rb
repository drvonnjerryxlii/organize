class Category < ActiveRecord::Base
  # Validations ----------------------------------------------------------------
  validates_presence_of :name

  # Associations ---------------------------------------------------------------
  belongs_to :categorizable, polymorphic: true
  has_many :category_joins
  has_many :notes, through: :category_joins, source: :categorizable,
    source_type: 'Note'
  has_many :broadcasts, through: :category_joins, source: :categorizable,
    source_type: 'Broadcast'
  has_many :users, through: :category_joins, source: :categorizable,
    source_type: 'User'
  has_many :guest_lectures, through: :category_joins, source: :categorizable,
    source_type: 'GuestLecture'
end
