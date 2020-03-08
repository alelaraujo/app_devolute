class Api::V1::AlbumsController < ApplicationController
    before_action :set_album, only: [:show, :edit, :update, :destroy]
 
    def index
      @albums = Album.all
      render json: @albums, methods: :photo_url
    end
  
    def show
    end

    def create
      @album = Album.new(album_params)
  
      respond_to do |format|
        if @album.save
          format.json { render :show, status: :created, location: @album }
        else
          format.json { render json: @album.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      if params[:file]
        @album.photo.attach(params[:file])
        photo = url_for(@album.photo)
      elsif params[:camera]
        blob = ActiveStorage::Blob.create_after_upload!(
          io: StringIO.new((Base64.decode64(params[:camera].split(",")[1]))),
          filename: "user.png",
          content_type: "image/png",
        )
        @album.photo.attach(blob)
        photo = url_for(@album.photo)
      else
        photo = album_params[:photo]
      end
      if @album.update(photo: photo)
        render json: @album, status: :ok
      end
    end
  
    def destroy
      @album.destroy
      respond_to do |format|
        format.json { head :no_content }
      end
    end
  

    private
      def set_album
        @album = Album.find(params[:id])
      end
  
      def album_params
        params.require(:album).permit(:name, :user_id, :photo)
      end
  end
  