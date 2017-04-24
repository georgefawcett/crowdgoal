class Event < ApplicationRecord

  belongs_to :user
  has_many :events_users
  has_many :users, :through => :events_users

  has_many :messages
  has_many :reviews

  validates :title, presence: true

  # before_validation :combine_datetime

  # private
  #   def combine_datetime
  #     self.expiry = "#{start_date} #{start_time}"
  #     puts self.expiry
  #   end
end
