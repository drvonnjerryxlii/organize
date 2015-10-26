class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.text :title,                           null: false
      t.text :description
      t.text :location
      t.datetime :start_time,                  null: false
      t.datetime :end_time,                    null: false
      t.text :google_event_id, limit: 1024
      t.boolean :admin_only,   default: false, null: false
      t.boolean :ta,           default: false, null: false
      t.boolean :gl,           default: false, null: false
      t.belongs_to :calendar
      t.belongs_to :guest_lecture
      t.belongs_to :user

      t.timestamps null: false
    end
    add_index :events, :calendar_id
    add_index :events, :guest_lecture_id
    add_index :events, :ta
    add_index :events, :gl
  end
end
