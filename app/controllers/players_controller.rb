class PlayersController < ApplicationController

include ApplicationHelper

  def create
    @events_user = EventsUser.new({
      event_id: params[:event_id],
      user_id: current_user.id
      })
    if @events_user.save
      @event = Event.find(params[:event_id])
      @players = @event.events_users
      joined_count = @players.length
      @email_ids = Array.new
      @players.each do |player|
        @email_ids.push(User.find(player.user_id).email)
      end
      render status: 200, json: {
        joined_count: joined_count
      }.to_json
      if @event.min_people == joined_count then
        UserMailer.confirmation_email(@event, @email_ids).deliver
      end
    else
      render status: 500, json: {
        error: @events_user.errors.full_messages,
      }.to_json
    end
  end

  def destroy
    puts params
    # @events_user = EventsUser.where(event_id: params[:event_id], user_id: params[:id]).destroy_all
    if EventsUser.where(event_id: params[:event_id], user_id: params[:id]).destroy_all
      @event = Event.find(params[:event_id])
      render status:200, json: {
        joined_count: EventsUser.where(event_id: params[:event_id]).count
      }.to_json
    else
      render status: 500, json: {
        error: @events_user.errors.full_messages,
      }.to_json
    end
  end

end
