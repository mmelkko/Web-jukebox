class Song < ActiveRecord::Base
	belongs_to :play_queue
	attr_accessible :soundcloud_id
end
