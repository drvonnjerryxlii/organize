class CreateCategoriesBroadcasts < ActiveRecord::Migration
  def change
    create_table :categories_broadcasts, id: false do |t|
      t.belongs_to :category, index: true, null: false# FIXME cat.title=prim key
      t.belongs_to :broadcast, index: true, null: false
    end
  end
end
