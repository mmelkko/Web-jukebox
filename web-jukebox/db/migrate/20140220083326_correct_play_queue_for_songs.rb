class CorrectPlayQueueForSongs < ActiveRecord::Migration
  def change
    drop_table :songs

    create_table :songs do |t|
      t.integer :soundcloud_id
      t.belongs_to :play_queue
      t.timestamps
    end
  end
end
