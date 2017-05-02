class Event < ApplicationRecord

  belongs_to :user
  belongs_to :sport

  has_many :events_users, dependent: :destroy
  has_many :users, :through => :events_users

  has_many :messages, dependent: :destroy
  has_many :reviews, dependent: :destroy

  has_many :galleries

  validates :title, presence: true, length: { maximum: 100 }
  validates :sport_id, presence: true
  validates :start_date, presence: true
  validates :start_time, presence: true
  validates :location, presence: true
  validates :min_people, presence: true
  validates :max_people, presence: true

  # before_validation :combine_datetime

  # private
  #   def combine_datetime
  #     self.expiry = "#{start_date} #{start_time}"
  #     puts self.expiry
  #   end

end
