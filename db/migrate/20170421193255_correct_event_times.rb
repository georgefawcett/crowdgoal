class CorrectEventTimes < ActiveRecord::Migration[5.0]
  def change
    change_table :events do |t|
      t.remove :start_time
      t.datetime :start_time
    end
  end
end
