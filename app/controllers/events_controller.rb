class EventsController < ApplicationController

  def index
    @events = Event.find(28);
  end

  def create
    event = Event.new(event_params)
    if event.save
      event_user = Events_User.new()
      redirect_to '/'
    else
      redirect_to '/'
    end
  end

  def show
    @event = Event.find(params[:id])
    @user = @event.user
  end

  private
  def event_params
    params.require(:event).permit(:sport_id, :title, :start_date, :start_time, :details, :location, :address, :min_people, :max_people, :expiry)
  end
end
