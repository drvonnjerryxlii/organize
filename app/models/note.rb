class Note < ActiveRecord::Base
  # Validations ----------------------------------------------------------------
  validates_presence_of :user_id, :note
  validates :user_id, numericality: { only_integer: true }

  # Associations ---------------------------------------------------------------
  belongs_to :user
  has_many :category_joins, as: :categorizable
  has_many :categories, through: :category_joins
end
