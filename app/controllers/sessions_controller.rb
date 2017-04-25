class SessionsController < ApplicationController

  include ApplicationHelper

  def index
    if current_user
      redirect_to '/events'
    else
      @user = User.new
    end
  end

  def create
    @user = User.find_by(email: user_params["email"])
    if @user && @user.valid_password?(user_params["password"])
      session[:user_id] = @user.id
      redirect_to '/events'
    else
      render :index
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
