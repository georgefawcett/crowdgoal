class ForgotPasswordController < ApplicationController

  def index
    @user = User.new
  end

  def create
    # puts params.inspect
    @user = User.find_by(email: params[:user_email]);
    if @user then
      @OTP = generate_OTP
      UserMailer.send_otp(@user, @OTP).deliver
      render status:200, json:{
        OTP: @OTP,
        user_id: @user.id
      }.to_json
    else
      render status:500, json:{
        message: "Invalid Email",
      }.to_json
    end
  end

  def update
    # puts params.inspect
    @user = User.find(params[:id])
    if @user.update(password_params) then
      session[:user_id] = @user.id
       render status:200, json:{
        message: "Password Updated"
      }.to_json
    else
      errors = Array.new
      @user.errors.full_messages.each do |error|
        errors.push(error)
      end
      render status:500, json:{
        message: errors
      }.to_json
    end
  end

  private

  def generate_OTP
    $collection='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvxyz0123456789'
    $i =  0
    $otp= ''
    while $i < 6 do
      $otp+=$collection[rand(60)]
      $i+=1
    end
    return $otp
  end

  def password_params
    params.require(:user_password).permit(:password, :password_confirmation)
  end

end

