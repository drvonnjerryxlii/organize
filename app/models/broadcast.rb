class Broadcast < ActiveRecord::Base
  # Associations ---------------------------------------------------------------
  has_many :category_joins, as: :categorizable
  has_many :categories, through: :category_joins

  # Validations ----------------------------------------------------------------
  validates_presence_of :title, :description
  validates :title, length: { maximum: 50 }
  validates :description, length: { maximum: 500 }, allow_blank: true

  # Scopes ---------------------------------------------------------------------
  scope :active, -> { where(active: true) }

  # Nested Attributes ----------------------------------------------------------
  accepts_nested_attributes_for :categories
end
