class AddAboutToUsers < ActiveRecord::Migration[5.0]
  def change
    change_table :users do |t|
      t.text :about
    end
  end
end
