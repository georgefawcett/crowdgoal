class SessionsController < ApplicationController

  def index
    @user = User.new
  end

  def create
    @user = User.find_by(email: user_params["email"])
    puts @user.inspect
    if @user && @user.valid_password?(user_params["password"])
      session[:user_id] = @user.id
      redirect_to '/events'
    else
      render :new
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
