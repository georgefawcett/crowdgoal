class EventsController < ApplicationController

  # before_validation(on: :create) do
  #   self.number = number.gsub(/[^0-9]/, "") if attribute_present?("number")
  # end


  def new
  end

  def create
    event = Event.new(event_params)
      if event.save
        redirect_to '/'
      else
        redirect_to '/'
      end
    end

 private

  def event_params
    params.require(:event).permit(:sport_id, :title, :start_time)
  end


end
