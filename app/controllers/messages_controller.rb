class MessagesController < ApplicationController


  def create

    message = Message.new(message_params)
    message.user_id = session[:user_id]

if message.save
      # redirect_to(controller: 'events', anchor: 'messages', id: 28)
      redirect_to :controller => 'events', :id => message.event_id, :anchor => 'messages', :action => 'show'
    else
      redirect_to '/'
    end
    puts message.errors.full_messages
  end






      # redirect_to(controller: 'events', anchor: 'messages', id: 28)
    #   redirect_to :controller => 'events', :id => message.event_id, :anchor => 'messages', :action => 'show'
    # else
    #   redirect_to '/'
    # end



  def destroy
    @message = Message.find params[:id]


      @message.destroy
      redirect_to :controller => 'events', :id => @message.event_id, :anchor => 'messages', :action => 'show', :notice => 'Comment deleted!'

  end


  private
  def message_params
    params.require(:message).permit(:user_id, :event_id, :message)

  end

end
