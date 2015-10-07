class CreateGuestLectures < ActiveRecord::Migration
  def change
    create_table :guest_lectures do |t|
      # t.integer :user_id, null: false
      t.belongs_to :users, index: true, null: false
      t.string :title, null: false
      t.string :short_description

      t.timestamps null: false
    end
  end
end
