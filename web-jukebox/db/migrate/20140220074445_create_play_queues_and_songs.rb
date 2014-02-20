class CreatePlayQueuesAndSongs < ActiveRecord::Migration
  def change
  	drop_table :songs
  	
  	create_table :play_queues do |t|

  	  t.timestamps
  	end

  	create_table :songs do |t|
  	  t.integer :soundcloud_id
  	  t.belongs_to :play_queue

  	  t.timestamps
  	end
  end
end
