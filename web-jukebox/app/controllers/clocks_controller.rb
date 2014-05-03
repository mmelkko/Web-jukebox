class ClocksController < ApplicationController
  require 'timers'

  def now
  	@timer = Clock.find(params[:id])

  	now = Time.now
  	song_time = now - @timer.start
  	render text: song_time
  end

  def test
  	render text: "It's the final countdown!"
  end

  def time_song
  	@clock = Clock.find(params[:id])

  	timers = Timers.new
  	song_timer = timers.after((@clock.duration/1000)) { render text: "Song ended now!" }

    render :nothing => true
  end

  private
    # Using a private method to encapsulate the permissible parameters is just a good pattern
    # since you'll be able to reuse the same permit list between create and update. Also, you
    # can specialize this method with per-user checking of permissible attributes.
    def clock_params

      params.require(:clock).permit!
    end
end
