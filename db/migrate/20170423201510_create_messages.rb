class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.integer :event_id
      t.text :message

      t.timestamps
    end
  end
end
