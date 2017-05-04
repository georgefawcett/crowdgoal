class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if !session[:user_id]
      session[:user_id] = User.find_by(email: @user.email).id
    end

    if @user.persisted?
      if @event.id
        redirect_to :controller => 'events', :id => @event.id
      else
        redirect_to events_path
      end
      # sign_in_and_redirect @user, :event => :authentication
      # set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      if @event.id
        redirect_to :controller => 'events', :id => @event.id
      else
        redirect_to events_path
      end
      # redirect_to 'events#index'
    end
  end

  def failure
    redirect_to root_path
  end
end