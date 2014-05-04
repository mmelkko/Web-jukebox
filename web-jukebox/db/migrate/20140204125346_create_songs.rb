class CreateSongs < ActiveRecord::Migration
  def up
    create_table :songs do |t|
      t.integer :soundcloud_id
      t.belongs_to :play_queue

      t.timestamps
    end
  end

  def down
  	drop_table :songs
  end
end
