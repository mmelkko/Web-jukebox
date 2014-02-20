class FixEverything < ActiveRecord::Migration
  def change
    drop_table :songs
    drop_table :play_queues
    drop_table :themes

    create_table :rooms do |t|
      t.timestamps
    end

    create_table :themes do |t|
      t.string :name
      t.belongs_to :room
      t.timestamps
    end

    create_table :play_queues do |t|
      t.timestamps
      t.belongs_to :room
    end

    create_table :songs do |t|
      t.integer :soundcloud_id
      t.belongs_to :play_queues
      t.timestamps
    end

  end
end
