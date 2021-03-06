class EventsController < ApplicationController
  include ApplicationHelper

  def index
  @user = User.new
  now = Time.now.beginning_of_day
  @events = Event.joins("INNER JOIN events_users
    ON events_users.event_id = events.id
    where events.start_date > '#{now}'
    group by events.id
    having count(events_users.event_id) < events.max_people
    order by start_date, start_time")

  end

  def new
    authorize
    @event = Event.new
  end

  def create
    authorize
    @event = Event.new(event_params)
    @event.user_id = session[:user_id]
    if @event.save
    # Add the organizer as a participant in their own event
    addplayer = EventsUser.new({
      event_id: @event.id,
      user_id: @event.user_id
      })
    addplayer.save
      redirect_to :controller => 'events', :id => @event.id, :action => 'show'
    else
      render :new
    end
    puts @event.errors.full_messages
  end


  def update
    authorize
    @event = Event.find(params[:id]).update(event_update_params)
    if (@event)
      render status:200, json:{
        message: "Saved."
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
    authorize
    # puts params[:reason]
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


  def refreshgames
    respond_to do |format|
    format.js
    end
  end


  private

  def event_params
    params.require(:event).permit(:user_id, :sport_id, :title, :start_date, :start_time, :details, :location, :address, :loc_lng, :loc_lat, :min_people, :max_people)

  end
  def event_update_params
    params.require(:event).permit(:start_date, :start_time, :details, :location, :address, :loc_lng, :loc_lat)
  end

end