class PhotosController < ApplicationController


 def create
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


 private

 #Permitted parameters when creating a photo. This is used for security reasons.
 def photo_params
  params.require(:photo).permit(:image)
 end

end