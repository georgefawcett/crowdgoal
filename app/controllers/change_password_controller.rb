class ChangePasswordController < ApplicationController

  include ApplicationHelper
  def change
    puts params.inspect
    if current_user
      puts current_user.inspect
    end
    @user = current_user
    if authenticate_password then
      # byebug
      if @user.update(password_params) then
        puts "Password Updated"
        render status:200, json:{
          message: "Password changed."
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
    else
      puts "incorrect password"
      render status: 500, json: {
        message: ["Incorrect old password"]
      }.to_json
    end
  end



  private
  def authenticate_password
    @user && @user.valid_password?(params[:old_password])
  end

  def password_params
    params.require(:user_password).permit(:password, :password_confirmation)
  end
end
