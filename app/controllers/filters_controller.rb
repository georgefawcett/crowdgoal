class FiltersController < ApplicationController
  def show
    @sport = Sport.find(params[:id])
    @events = @sport.events.order(:start_date)
    render 'events/index'
  end
end
