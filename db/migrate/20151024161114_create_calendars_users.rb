class CreateCalendarsUsers < ActiveRecord::Migration
  def change
    create_table :calendars_users, id: false do |t|
      t.belongs_to :calendar, null: false
      t.belongs_to :user, null: false
    end
    add_index :calendars_users, :calendar_id
    add_index :calendars_users, :user_id
  end
end
