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

  def register_client
    # register a client with YOUR_CLIENT_ID as client_id_
    # YOUR_CLIENT_ID = 86898a442cab8a6489b73d3e8d927acf
    @client = SoundCloud.new({
        :client_id      => "86898a442cab8a6489b73d3e8d927acf",
        :client_secret => "d43c8c54c71cd73f771b0e69d8a714a9",
        :username      => 'punkkulaatta',
        :password      => 'REMOVED FOR OBVIOUS REASONS'
    })
    # get 10 hottest tracks
    # tracks = @client.get('/tracks', :limit => 10, :order => 'hotness')
    # print each link
    # DOES NOT WORK
    # tracks.each do |track|
    #  puts track.permalink_url
    # end

    # current_user = client.get('/me')
    # puts current_user.username

  end

  def manage
    @room = Room.find(params[:id])

    # TODO: poista atm soiva biisi

    @client = SoundCloud.new(:client_id => "86898a442cab8a6489b73d3e8d927acf")

    logger.info("Client: %p" % @client)

    track = @client.get("/tracks/138087598")
    @room.clock.duration = track.duration

    @room.clock.start = Time.now

    redirect_to time_song_room_clock_path(@room, @room.clock)

  end

  private
    # Using a private method to encapsulate the permissible parameters is just a good pattern
    # since you'll be able to reuse the same permit list between create and update. Also, you
    # can specialize this method with per-user checking of permissible attributes.
    def room_params

      params.require(:room).permit!
    end

end
