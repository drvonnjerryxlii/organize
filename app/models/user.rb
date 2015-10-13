class User < ActiveRecord::Base
  # Validations ----------------------------------------------------------------
  validates_presence_of :name, :email, :type
  validates :name, length: { maximum: 250 }
  validates :email, length: { maximum: 320 }

  # Associations ---------------------------------------------------------------
  has_many :oauths
  has_many :guest_lectures
  has_many :notes
  has_and_belongs_to_many :cohorts
  has_and_belongs_to_many :events
  has_many :category_joins, as: :categorizable
  has_many :categories, through: :category_joins
  has_many :broadcasts, through: :categories
end
