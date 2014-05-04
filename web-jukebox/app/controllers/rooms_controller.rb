class RoomsController < ApplicationController

  require 'soundcloud'

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

  # POST time
  def time
    @room = Room.find(params[:id])
    time_left = @room.clock.duration-(Time.now.utc.to_i-@room.clock.start)

    logger.info("***** There is #{time_left} seconds left until this song ends. *****")

    if time_left < 1
      time_left = 0
    end

    render text: "#{@room.clock.start > 0 ? time_left : 0}"
  end

  # POST next song soundcloud id and remove previous song
  def next_song
    @room = Room.find(params[:id])
    
    begin
      unless @room.play_queue.songs.first.blank?
        @room.play_queue.songs.delete(@room.play_queue.songs.first)
        @room.play_queue.songs.first.destroy
        if @room.play_queue.songs.first.blank?
          @room.play_queue.songs.create(soundcloud_id: "19306001",
            image_url: "http://i1.sndcdn.com/artworks-000009442684-7zgvh4-large.jpg?61e8f21",
            url: "http://soundcloud.com/beyoncemusic/best-thing-i-never-had-dj",
            name: "Best Thing I Never Had [DJ Escape & Tony Coluccio Dub Remix]",
            creator: "Beyonce",
            duration: 367186)
        end
      else
        @room.play_queue.songs.create(soundcloud_id: "19306001",
          image_url: "http://i1.sndcdn.com/artworks-000009442684-7zgvh4-large.jpg?61e8f21",
          url: "http://soundcloud.com/beyoncemusic/best-thing-i-never-had-dj",
          name: "Best Thing I Never Had [DJ Escape & Tony Coluccio Dub Remix]",
          creator: "Beyonce",
          duration: 367186)
      end

      @room.play_queue.save 
      @room.save

      @client = SoundCloud.new(:client_id => "86898a442cab8a6489b73d3e8d927acf")
      track = @client.get("/tracks/#{@room.play_queue.songs.first.soundcloud_id}")
    rescue SoundCloud::ResponseError
      retry
    end

    @room.clock.duration = track.duration/1000
    @room.clock.start = Time.now.utc
    @room.clock.save

    render text: "#{@room.play_queue.songs.first.soundcloud_id}"
  end

  private
    # Using a private method to encapsulate the permissible parameters is just a good pattern
    # since you'll be able to reuse the same permit list between create and update. Also, you
    # can specialize this method with per-user checking of permissible attributes.
    def room_params

      params.require(:room).permit!
    end

end
