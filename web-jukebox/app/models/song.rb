class Song < ActiveRecord::Base
	belongs_to :play_queue
end
