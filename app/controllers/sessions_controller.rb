class SessionsController < ApplicationController

  include ApplicationHelper

  def index
      @user = User.new
      redirect_to '/events'
  end

  def mobile
    @user = User.new
  end

  def create
    @user = User.find_by(email: user_params["email"])
    if @user && @user.valid_password?(user_params["password"])
      session[:user_id] = @user.id
      redirect_to '/events'
    else
      puts params
      flash.now[:alert] = ["Invalid Username or Password"]
      if params[:source]
        render :mobile
      else
        @events = Event.all
        render template: "events/index"
      end
      # render Rails.application.routes.recognize_path(request.referer)[:action]
    end
  end

  def destroy
    authorize
    session[:user_id] = nil
    redirect_to '/'
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
