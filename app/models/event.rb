class Event < ApplicationRecord

  belongs_to :user
  belongs_to :sport
  has_many :events_users
  has_many :users, :through => :events_users
  validates :title, presence: true

  before_validation :combine_datetime

  private
    def combine_datetime
      self.expiry = "#{start_date} #{start_time}"
      puts self.expiry
    end
end
