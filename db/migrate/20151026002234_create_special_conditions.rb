class CreateSpecialConditions < ActiveRecord::Migration
  def change
    create_table :special_conditions do |t|
      t.integer :new_ta_requirement, null: false
      t.datetime :date,              null: false
      t.belongs_to :calendar
      t.timestamps                   null: false
    end
    add_index :special_conditions, :date
    add_index :special_conditions, :calendar_id
  end
end
