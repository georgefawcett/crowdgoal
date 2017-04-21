class Event < ApplicationRecord


  validates :title, presence: true




# before_create :combine_datetime

#  private
#      def combine_datetime
#      self.title = "#{params[:event][:title]} test!"
#     end
end
