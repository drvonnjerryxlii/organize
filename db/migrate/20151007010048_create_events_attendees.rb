class CreateEventsAttendees < ActiveRecord::Migration
  def change
    create_table :events_attendees, id: false do |t|
      t.belongs_to :event, index: true, null: false
      t.belongs_to :user, index: true, null: false
    end
  end
end
