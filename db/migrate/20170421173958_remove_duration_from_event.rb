class RemoveDurationFromEvent < ActiveRecord::Migration[5.0]
  def change
    change_table :events do |t|
      t.remove :duration
      t.datetime :start_date
    end
  end
end
