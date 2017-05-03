class ReviewsController < ApplicationController
  include ApplicationHelper
   def create
    authorize
    review = Review.new(review_params)
    review.user_id = session[:user_id]

    if review.save
      # redirect_to(controller: 'events', anchor: 'messages', id: 28)
      redirect_to :controller => 'events', :id => review.event_id, :anchor => 'reviews', :action => 'show'
    else
      redirect_to '/'
    end
    puts review.errors.full_messages
  end


  def destroy
    authorize
    @review = Review.find params[:id]


      @review.destroy
      redirect_to :controller => 'events', :id => @review.event_id, :anchor => 'reviews', :action => 'show', :notice => 'Comment deleted!'

  end


  private
  def review_params
    params.require(:review).permit(:user_id, :event_id, :rating, :review)

  end

end
