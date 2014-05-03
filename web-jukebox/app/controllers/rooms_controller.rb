class RoomsController < ApplicationController
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
    @room = Room.find(params[:id])
    @room.register_soundcloud_client
  end

  def manage
    @room = Room.find(params[:id])

    # TODO: [aseta room.timer.durationiin trackin duration tässä]

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
