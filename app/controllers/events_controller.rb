class EventsController < ApplicationController



  def index

  now = Time.now
  @events = Event.where('start_date > :end',
    :end=> now.beginning_of_day,
  )

  end

  def create


    event = Event.new(event_params)
    event.user_id = session[:user_id]



    if event.save
 # Add the organizer as a participant in their own event
    addplayer = EventsUser.new({
      event_id: event.id,
      user_id: event.user_id
      })
    addplayer.save
      redirect_to :controller => 'events', :id => event.id, :action => 'show'
    else
      redirect_to '/'
    end
    puts event.errors.full_messages
  end


  def update
    @event = Event.update(params[:event_id], start_date: params[:event_start_date], start_time: Time.parse(params[:event_start_time]), location: params[:event_location]);
    if (@event)
      render status:200, json:{
        message: "saved."
      }
    else
    render status: 500, json: {
        message: "Internal Server Error.",
      }.to_json
    end
  end


  def show
    @event = Event.find(params[:id])
    @user = @event.user
    @players = @event.events_users
    @messages = @event.messages.order(created_at: :desc)
    @reviews = @event.reviews.order(created_at: :desc)
    @galleries = @event.galleries.order(created_at: :desc)


  end

  def destroy
    puts params[:reason]
    @event = Event.find(params[:id]);
    @players = @event.events_users
    @email_ids = Array.new
    @players.each do |player|
      @email_ids.push(User.find(player.user_id).email)
    end
    # @email_ids = User.where(id: @players.collect(&:user_id).join(",")).all.collect(&:email).join(",")
    if Event.destroy(params[:id])
      UserMailer.cancellation_email(@event, @email_ids, params[:reason]).deliver
      render status:200, json:{
        message:"Event deleted."
      }.to_json
    else
      render status:500, json:{
        message:"Internal Server Error."
      }.to_json
    end
  end

  private

  def event_params
    params.require(:event).permit(:user_id, :sport_id, :title, :start_date, :start_time, :details, :location, :address, :loc_lng, :loc_lat, :min_people, :max_people)

  end
end