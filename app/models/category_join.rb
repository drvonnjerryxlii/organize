require Rails.root.join('lib/build_constraints_regex')

class CategoryJoin < ActiveRecord::Base
  # Associations ---------------------------------------------------------------
  belongs_to :categorizable, polymorphic: true
  belongs_to :category

  # Validations ----------------------------------------------------------------
  validates_presence_of :category_id, :categorizable_id, :categorizable_type
  validates :category_id, numericality: { only_integer: true }
  validates :categorizable_id, numericality: { only_integer: true }

  categorizable_types = ["Broadcast", "GuestLecture", "Note", "User"]
  CATEGORIZABLE_CONSTRAINTS = build_contraints_regex(categorizable_types)

  validates_format_of :categorizable_type, with: CATEGORIZABLE_CONSTRAINTS
end
