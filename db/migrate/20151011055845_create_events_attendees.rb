class CreateEventsAttendees < ActiveRecord::Migration
  def change
    create_table :events_users, id: false do |t|
      t.belongs_to :event, null: false
      t.belongs_to :user, null: false
    end
    add_index :events_users, :event_id
    add_index :events_users, :user_id
  end
end
