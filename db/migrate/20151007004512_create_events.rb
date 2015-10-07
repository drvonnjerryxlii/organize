class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.datetime :start, null: false
      t.datetime :end, null: false
      t.string :google_id, null: false

      t.timestamps null: false
    end
  end
end
