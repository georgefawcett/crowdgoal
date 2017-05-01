class UsersController < ApplicationController

  include ApplicationHelper

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
      if (@user.save)
        session[:user_id] = @user.id
        redirect_to '/events'
      else
        render :new
      end
  end

  def edit
    @user = current_user;
  end

  def update
    @user = current_user
    if @user.update(update_params)
      render status:200, json:{
          message: "Info updated."
        }
    else
      errors = Array.new
        @user.errors.full_messages.each do |error|
          errors.push(error)
        end

        render status:500, json:{
          message: errors
        }
    end
  end

  def show
    @user = User.find(params[:id])
    @created = Event.where(user_id: @user.id)
    @galleries = Gallery.where(user_id: @user.id).order(created_at: :desc)
    @joined = "SELECT count(*) FROM events_users
                     WHERE  user_id = #{@user.id}"
    activity_sql = "select events.id, events.title, events.user_id, events.sport_id, sports.icon, events.created_at as \"jointime\"
                    from (events
                    inner join sports ON events.sport_id = sports.id)
                    where user_id = #{@user.id}
                    union
                    select events.id, events.title, events.user_id, events.sport_id, sports.icon, events_users.created_at as \"jointime\"
                    from ((events
                    inner join events_users ON events.id = events_users.event_id)
                    inner join sports ON events.sport_id = sports.id)
                    where events_users.user_id = #{current_user.id}
                    and events.user_id != #{@user.id}
                    order by jointime desc
                    limit 20"
    @activity = ActiveRecord::Base.connection.execute(activity_sql)
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

  def update_params
    params.require(:user_info).permit(:name, :about)
  end

end
