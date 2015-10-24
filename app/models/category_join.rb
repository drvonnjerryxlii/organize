# require Rails.root.join('lib/build_constraints_regex')

class CategoryJoin < ActiveRecord::Base
  # Validations ----------------------------------------------------------------
  validates_presence_of :category_id, :categorizable_id, :categorizable_type
  validates :category_id, numericality: { only_integer: true }
  validates :categorizable_id, numericality: { only_integer: true }
  validate :valid_categorizable_type # FIXME: this isn't tested

  # Associations ---------------------------------------------------------------
  belongs_to :categorizable, polymorphic: true
  belongs_to :category

  private
    def valid_categorizable_type
      valid_types = ["Broadcast", "GuestLecture", "Note", "User"]
      return valid_types.include? :categorizable_type
    end
end
