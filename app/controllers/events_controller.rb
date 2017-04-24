class EventsController < ApplicationController



  def index
    @events = Event.find(28);
  end

  def create


    event = Event.new(event_params)
    event.user_id = session[:user_id]

    # Add the organizer as a participant in their own event


    if event.save

      redirect_to '/'
    else
      redirect_to '/'
    end
    puts event.errors.full_messages
  end

  def show
    @event = Event.find(params[:id])
    @user = @event.user
    @players = @event.events_users
    @messages = @event.messages.order(created_at: :desc)
    @reviews = @event.reviews.order(created_at: :desc)



  end

  private

  def event_params
    params.require(:event).permit(:user_id, :sport_id, :title, :start_date, :start_time, :details, :location, :address, :loc_lng, :loc_lat, :min_people, :max_people)

  end
end
