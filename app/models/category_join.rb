class CategoryJoin < ActiveRecord::Base
  validates_presence_of :category_id, :categorizable_id, :categorizable_type
end
