class PhotosController < ApplicationController
  include ApplicationHelper
 # #Index action, photos gets listed in the order at which they were created
 # def index
 #  @photos = Photo.order('created_at')
 # end

 # #New action for creating a new photo
 # def new
 #  @photo = Photo.new
 # end



 def create
    authorize
    @photo = Photo.new(params[:photo])

    if @photo.save
      respond_to do |format|
        format.html {
          render :json => [@photo.to_jq_upload].to_json,
          :content_type => 'text/html',
          :layout => false
        }
        format.json {
          render :json => [@photo.to_jq_upload].to_json
        }
      end
    else
      render :json => [{:error => "custom_failure"}], :status => 304
    end
    puts @photo.errors.full_messages
  end



 # def create
 #  @photo = Photo.new(photo_params)
 #  if @photo.save
 #   flash[:notice] = "Successfully added new photo!"
 #   redirect_to root_path
 #  else
 #   flash[:alert] = "Error adding new photo!"
 #   render :new
 #  end
 # end

 private

 #Permitted parameters when creating a photo. This is used for security reasons.
 def photo_params
  params.require(:photo).permit(:image)
 end

end