class RemovePlayQueues < ActiveRecord::Migration
  def change
  	drop_table :play_queues
  	drop_table :rooms
  end
end
