require "mini_magick"
class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :edit, :update, :destroy]

  # GET /albums
  # GET /albums.json
  def index
    @albums = Album.all
  end

  # GET /albums/1
  # GET /albums/1.json
  def show
  end

  # GET /albums/new
  def new
    @album = Album.new
  end

  # GET /albums/1/edit
  def edit
  end

  # POST /albums
  # POST /albums.json
  def create
    @album = Album.new(album_params)
    @album.user = current_user

    respond_to do |format|
      if @album.save
        format.html { redirect_to @album, notice: 'Album was successfully created.' }
        format.json { render :show, status: :created, location: @album }
      else
        format.html { render :new }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /albums/1
  # PATCH/PUT /albums/1.json
  # def update
  #   respond_to do |format|
  #     if @album.update(album_params)
  #       format.html { redirect_to @album, notice: 'Album was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @album }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @album.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def update
    if params[:file]
      # The data is a file upload coming from <input type="file" />
      @album.photo.attach(params[:file])
      # Generate a url for easy display on the front end 
      photo = url_for(@album.photo)
    elsif params[:camera]
      # The data is Base64 and coming from the camera.  
      # Use that data to create a file for active storage.
      blob = ActiveStorage::Blob.create_after_upload!(
        io: StringIO.new((Base64.decode64(params[:camera].split(",")[1]))),
        filename: "user.png",
        content_type: "image/png",
      )
      @album.photo.attach(blob)
      photo = url_for(@album.photo)
    else
      # Maybe we want to just store a url or the raw Base64 data
      photo = album_params[:photo]
    end
      # Now save that url in the profile
    if @album.update(photo: photo)
      render json: @album, status: :ok
    end
  end



  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    @album.destroy
    respond_to do |format|
      format.html { redirect_to albums_url, notice: 'Album was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def album_params
      params.require(:album).permit(:name, :user_id, :photo)
    end
end
