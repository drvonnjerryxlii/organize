class GuestLecture < ActiveRecord::Base
  # Validations ----------------------------------------------------------------
  validates_presence_of :user_id, :title
  validates :user_id, numericality: { only_integer: true }
  validates :title, length: { maximum: 50 }
  validates :description, length: { maximum: 500 }, allow_blank: true

  # Associations ---------------------------------------------------------------
  belongs_to :user
  has_many :category_joins, as: :categorizable
  has_many :categories, through: :category_joins
end
