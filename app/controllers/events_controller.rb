class EventsController < ApplicationController

include ApplicationHelper

  def index
    @events = Event.all;
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

  def update
    # format.json { render :status => :unprocessable_entity ,
    #   :json => { :error_message => "Couldn't update!"}}

    # respond_to do |format|
    #   # format.html # show.html.erb
    #   format.json { render json: {:message => "failure"}, :status => 500 }
    #  end
    # render status: 500, json: {
    #   message: "Couldn't update!",
    # }.to_json
    # # byebug
    # @event = Event.find(params[:id])

    @events_user = EventsUser.new({
      event_id: params[:id],
      user_id: current_user.id
      })
    if @events_user.save
      @event = Event.find(params[:id])
      render status: 200, json: {
        joined_count: EventsUser.where(event_id: params[:id]).count,
        min_poeple: @event.min_people,
        max_people: @event.max_people
      }.to_json
    else
      render status: 500, json: {
        error: @events_user.errors.full_messages,
      }.to_json
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
