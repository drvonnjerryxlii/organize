class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.text :name, null: false
      t.text :google_calendar_id, null: false
      t.text :token
      t.text :access_type

      t.timestamps null: false
    end
  end
end
