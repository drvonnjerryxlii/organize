class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.belongs_to :user, null: false
      t.text :note, null: false

      t.timestamps null: false
    end
    add_index :notes, :user_id
  end
end
