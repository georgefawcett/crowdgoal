class AddLatLngToEvents < ActiveRecord::Migration[5.0]
  def change
    change_table :events do |t|
      t.string :loc_lat
      t.string :loc_lng
    end
  end
end
