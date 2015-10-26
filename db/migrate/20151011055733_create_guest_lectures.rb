class CreateGuestLectures < ActiveRecord::Migration
  def change
    create_table :guest_lectures do |t|
      t.belongs_to :user, null: false
      t.text :title, limit: 50, null: false
      t.text :description, limit: 500

      t.timestamps null: false
    end
    add_index :guest_lectures, :user_id
  end
end
