class Review < ApplicationRecord

  belongs_to :event
  belongs_to :user

  validates :user_id, :event_id, :rating, :review, presence: true

end
