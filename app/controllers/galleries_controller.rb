class GalleriesController < ApplicationController
  def create

     @gallery = Gallery.new(gallery_params)
     @gallery.user_id = session[:user_id]


if params[:images]

    if @gallery.save
        puts params[:images]
        params[:images].each { |image|
          @gallery.photos.create(image: image)
        }


      redirect_to :controller => 'events', :id => @gallery.event_id, :anchor => 'photos', :action => 'show'

    else
      redirect_to :controller => 'events', :id => @gallery.event_id, :anchor => 'photos', :action => 'show', :notice => 'Your upload failed.'
    end
    puts @gallery.errors.full_messages

else
  redirect_to :controller => 'events', :id => @gallery.event_id, :anchor => 'photos', :action => 'show', :notice => 'No photos'
end

  end


  def destroy
    @gallery = Gallery.find params[:id]


      @gallery.destroy
      if params[:refer] == "user"
        redirect_to :controller => 'users', :id => @gallery.user_id, :anchor => 'myphotos', :action => 'show', :notice => 'Gallery deleted!'
      else
        redirect_to :controller => 'events', :id => @gallery.event_id, :anchor => 'photos', :action => 'show', :notice => 'Gallery deleted!'
      end
  end


  private

  def gallery_params
    params.require(:gallery).permit(:user_id, :event_id, :images)

  end

end
