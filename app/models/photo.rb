class Photo < ApplicationRecord

  belongs_to :gallery

    #Mounts paperclip image
  has_attached_file :image, :styles => {
      :thumb => "200x",
      :display  => "500x"
      }

#This validates the type of file uploaded. According to this, only images are allowed.
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

end
