class AmendGalleries < ActiveRecord::Migration[5.0]
  def change
    change_table :photos do |t|
      t.remove :images
    end

    change_table :galleries do |t|
      t.text :images
    end
  end
end
