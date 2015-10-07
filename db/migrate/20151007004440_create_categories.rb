class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name, null: false # FIXME: how primary key this line?
      t.string :color, default: "white"
      t.boolean :admin_only, default: true

      t.timestamps null: false
    end
  end
end
