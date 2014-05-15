class PlayQueuesController < ApplicationController

  # GET /play_queues/1
  # GET /play_queues/1.json
  def show
    @play_queue = PlayQueue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @play_queue }
    end
  end

  # GET /play_queues/1/edit
  def edit
    @play_queue = PlayQueue.find(params[:id])
  end

  # PUT /play_queues/1
  # PUT /play_queues/1.json
  def update
    @play_queue = PlayQueue.find(params[:id])
    @client = SoundCloud.new(:client_id => "86898a442cab8a6489b73d3e8d927acf")

    @play_queue.songs.each do |song|
      unless song.id.nil?
        if song.image_url.blank?
          begin
            track = @client.get("/tracks/#{song.soundcloud_id}")
            song.image_url = track.artwork_url
            song.url = track.permalink_url
            song.name = track.title
            song.creator = track.user.username
            song.save
          rescue SoundCloud::ResponseError
            next
          end
        end
      end
    end

    respond_to do |format|
      if @play_queue.update_attributes(play_queue_params)
        format.html { redirect_to room_path(@play_queue.room), notice: 'Play queue was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @play_queue.room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /play_queues/1
  # DELETE /play_queues/1.json
  def destroy
    @play_queue = PlayQueue.find(params[:id])
    @play_queue.destroy

    respond_to do |format|
      format.html { redirect_to play_queues_url }
      format.json { head :no_content }
    end
  end

  private
    # Using a private method to encapsulate the permissible parameters is just a good pattern
    # since you'll be able to reuse the same permit list between create and update. Also, you
    # can specialize this method with per-user checking of permissible attributes.
    def play_queue_params
      params.require(:play_queue).permit!
    end
end
