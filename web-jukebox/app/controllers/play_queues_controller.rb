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

    respond_to do |format|
      if @play_queue.update_attributes(params[:play_queue])
        format.html { redirect_to @play_queue, notice: 'Play queue was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @play_queue.errors, status: :unprocessable_entity }
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
end