class CreateCategoryJoins < ActiveRecord::Migration
  def change
    create_table :category_joins do |t|
      t.belongs_to :category, null: false
      t.string :categorizable_type, null: false
      t.integer :categorizable_id, null: false

      t.timestamps null: false
    end
    add_index :category_joins, :category_id
    add_index :category_joins, [:categorizable_id, :categorizable_type]
  end
end
