class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.integer :user_id
      t.integer :sport_id
      t.string :title
      t.text :details
      t.timestamp :start_time
      t.float :duration
      t.string :loc_name
      t.string :loc_address
      t.float :loc_x
      t.float :loc_y
      t.integer :loc_area_id
      t.integer :min_people
      t.integer :max_people
      t.timestamp :expiry

      t.timestamps
    end
  end
end
