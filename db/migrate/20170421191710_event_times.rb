class EventTimes < ActiveRecord::Migration[5.0]
  def change
    change_column :events, :start_date, :date
    change_column :events, :start_time, :time
  end
end
