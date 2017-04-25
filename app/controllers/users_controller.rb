class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    byebug
    @user = User.new(user_params)
    # @user.password = user_params["password"]
    # if password_matches? then
      if (@user.save)
        session[:user_id] = @user.id
        redirect_to '/events'
      else
        render :new
      end
    # else
    #   @user.errors.add(:password, "Password did not match!")
    #   render :new
    # end
  end

  def show
    @user = User.find(params[:id])
  end


  private

  def password_matches?
    params["password"] == params["password_confirmation"]
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
