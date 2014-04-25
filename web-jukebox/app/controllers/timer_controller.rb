class TimerController < ApplicationController
  def now
  	render text: "It's the final countdown!"
  end

  private
    # Using a private method to encapsulate the permissible parameters is just a good pattern
    # since you'll be able to reuse the same permit list between create and update. Also, you
    # can specialize this method with per-user checking of permissible attributes.
    def timer_params

      params.require(:timer).permit!
    end
end
