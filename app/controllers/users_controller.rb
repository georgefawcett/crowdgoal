class UsersController < ApplicationController

  include ApplicationHelper

  def new
    @user = User.new
  end

  def create
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
    @created = Event.where(user_id: @user.id)

    @joined = "SELECT count(*) FROM events_users
                     WHERE  user_id = #{@user.id}"




    following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = #{@user.id}"
    @following = User.where("id IN (#{following_ids})")

    follower_ids = "SELECT follower_id FROM relationships
                     WHERE  followed_id = #{@user.id}"
    @followers = User.where("id IN (#{follower_ids})")





  end


  private

  def password_matches?
    params["password"] == params["password_confirmation"]
  end

  def user_params
    params.require(:user).permit(:name, :email, :picture, :about, :password, :password_confirmation)
  end

end
