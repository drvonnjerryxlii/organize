class CategoryJoin < ActiveRecord::Base
  # Validations ----------------------------------------------------------------
  validates_presence_of :category_id, :categorizable_id, :categorizable_type
  validates :category_id, numericality: { only_integer: true }
  validates :categorizable_id, numericality: { only_integer: true }

  # Associations ---------------------------------------------------------------
  belongs_to :categorizable, polymorphic: true
  belongs_to :category
end
