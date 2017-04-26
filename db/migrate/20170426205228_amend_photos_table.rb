class AmendPhotosTable < ActiveRecord::Migration[5.0]
  def change
    change_table :photos do |t|
      t.integer :gallery_id
      t.remove :title
    end
  end
end
