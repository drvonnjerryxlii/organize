class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.citext :name,                           null: false
      t.text :description
      t.boolean :user_related,                  null: false
      t.boolean :topic_related,                 null: false
      t.boolean :admin_only,    default: true,  null: false
      t.boolean :approved,      default: false, null: false
      t.boolean :hidden,        default: false, null: false

      t.timestamps null: false
    end
    add_index :categories, :name, unique: true
    add_index :categories, :hidden
    add_index :categories, :admin_only
    add_index :categories, :user_related
    add_index :categories, :topic_related
  end
end
