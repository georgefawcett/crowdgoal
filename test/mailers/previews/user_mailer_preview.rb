# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def cancellation_email_preview
    UserMailer.cancellation_email(User.find(3))
  end
end
