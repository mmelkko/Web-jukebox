class TimerController < ApplicationController
  def now
  	render text: "It's the final countdown!"
  end
end
