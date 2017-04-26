class UserMailer < ApplicationMailer
  default from: "notifications.crowdgoal@gmail.com"

  def cancellation_email(event, email_ids, reason)
    @event = event
    @reason = reason
      mail(to: email_ids, subject: 'Cancel Notification: ' + @event.title)
  end

end
