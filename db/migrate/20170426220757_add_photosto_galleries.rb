class AddPhotostoGalleries < ActiveRecord::Migration[5.0]
  def change
     change_table :photos do |t|
      t.text :images
    end
  end
end
