class EventLocations < ActiveRecord::Migration[5.0]
  def change
    change_table :events do |t|
      t.remove :loc_name
      t.remove :loc_address
      t.remove :loc_x
      t.remove :loc_y
      t.string :location
    end
  end
end
