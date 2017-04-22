class EventsController < ApplicationController

  # before_validation(on: :create) do
  #    self.start_date = number.gsub(/[^0-9]/, "") if attribute_present?("number")
  #  end





  def new
  end

  def create
    # params[:event][:start_time] = "#{params[:start_date]} #{params[:start_date]}"
    # params[:event].except!(:start_date)
    # puts params


    event = Event.new(event_params)

    # puts event_params
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
    # puts params[:event][:title]
  #   # params[:start_time] = "01:00:00"
  #   # params

   end


end
