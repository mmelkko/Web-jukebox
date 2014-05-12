class TimerController < ApplicationController
  def now
  	@timer = Timer.find(params[:timer])

  	now = Time.now.utc
  	song_time = now - @timer.start
  	render text: song_time
  end

  def test
  	render text: "It's the final countdown!"
  end

  def time_song
  	@timer = Timer.find(params[:timer])

  	timer = Timers.new
  	song_timer = timers.after((self.duration/1000)) { render text: "Song ended now!" }
  end

  private
    # Using a private method to encapsulate the permissible parameters is just a good pattern
    # since you'll be able to reuse the same permit list between create and update. Also, you
    # can specialize this method with per-user checking of permissible attributes.
    def timer_params

      params.require(:timer).permit!
    end
end
