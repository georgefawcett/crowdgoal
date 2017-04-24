class Message < ApplicationRecord

  belongs_to :event
  belongs_to :user

  validates :user_id, :event_id, :message, presence: true

end
