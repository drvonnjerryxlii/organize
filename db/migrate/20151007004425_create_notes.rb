class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.belongs_to :users, index: true, null: false
      t.string :note, null: false
      t.string :color, default: "white"

      t.timestamps null: false
    end
  end
end
