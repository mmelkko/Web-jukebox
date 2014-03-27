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

  private
    # Using a private method to encapsulate the permissible parameters is just a good pattern
    # since you'll be able to reuse the same permit list between create and update. Also, you
    # can specialize this method with per-user checking of permissible attributes.
    def room_params

      params.require(:room).permit(
        play_queue_attributes: [
          :id,
          :room,
          song_attributes: [
            :id,
            :soundcloud_id]],
        )
    end

end
