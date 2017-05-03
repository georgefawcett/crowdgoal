class FiltersController < ApplicationController
  def show
    @sport = Sport.find(params[:id])
    @events = @sport.events.where("start_date > ?", Time.now.to_date).order(:start_date)
    @user = User.new
    render 'events/index'
  end
end
