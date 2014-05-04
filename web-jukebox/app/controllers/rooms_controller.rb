class RoomsController < ApplicationController

  require 'soundcloud'

  before_filter :set_client, :except => [:create, :update, :destroy, :index]
  def set_client
    @client = SoundCloud.new(:client_id => "86898a442cab8a6489b73d3e8d927acf")
  end

  # GET /rooms
  # GET /rooms.json
  def index
    @rooms = Room.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rooms }
    end
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
    @room = Room.find(params[:id])
    @play_queue = @room.play_queue
    @play_queue.songs.build # in case user wants to add a song
    # this is done here because ror has made it impossible to open a controller action
    # in a modal page and go through the controller also. Try google it - no way unless
    # you do super javascript trix

    if @room.clock.start.nil?
      @room.clock.start = Time.now
      
      unless @room.play_queue.songs.first.blank?
        @client = SoundCloud.new(:client_id => "86898a442cab8a6489b73d3e8d927acf")
        track = @client.get("/tracks/#{@room.play_queue.songs.first.soundcloud_id}")
        @room.clock.duration = track.duration
      else
        # TODO what if there's no song in the queue
      end
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @room }
    end
  end

  # PUT /rooms/1
  # PUT /rooms/1.json
  def update
    @room = Room.find(params[:id])

    respond_to do |format|
      if @play_queue.update_attributes(params[:room])
        format.html { redirect_to @room, notice: 'Room was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "index" }
        format.json { render json: @play_queue.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST time
  def time
    @room = Room.find(params[:id])
    elapsed = Time.now - @room.clock.start
    time = (@room.clock.duration - elapsed)

    if time < 1000 # time is milliseconds, so...
      time = 0

      # trying to fetch the duration of the next song from soundcloud.
      begin
        @client = SoundCloud.new(:client_id => "86898a442cab8a6489b73d3e8d927acf")

        unless @room.play_queue.songs.first.blank?
          @room.play_queue.songs.first.destroy
        end

        # TODO: what if there is no song in the queue
        # TODO: getting the next song from the queue to the widget player

        unless @room.play_queue.songs.first.blank? # if there's no song, let's not do anything

          track = @client.get("/tracks/#{@room.play_queue.songs.first.soundcloud_id}")

          @room.clock.duration = track.duration
          @room.clock.start = Time.now
          @room.clock.save
        end

      rescue SoundCloud::ResponseError
        retry

      end
    end

    render text: "#{time}"

  end

  private
    # Using a private method to encapsulate the permissible parameters is just a good pattern
    # since you'll be able to reuse the same permit list between create and update. Also, you
    # can specialize this method with per-user checking of permissible attributes.
    def room_params

      params.require(:room).permit!
    end

end
