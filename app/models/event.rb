class Event < ApplicationRecord


  validates :title, presence: true




before_validation :combine_datetime

 private
     def combine_datetime
     self.expiry = "#{start_date} #{start_time}"
     puts self.expiry
    end
end
