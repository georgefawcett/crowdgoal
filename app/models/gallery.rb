class Gallery < ApplicationRecord

  belongs_to :user
  belongs_to :event

  has_many :photos, :dependent => :destroy

end
