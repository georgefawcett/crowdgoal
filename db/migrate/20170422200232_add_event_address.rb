class AddEventAddress < ActiveRecord::Migration[5.0]
  def change
     change_table :events do |t|
      t.string :address
    end
  end
end
