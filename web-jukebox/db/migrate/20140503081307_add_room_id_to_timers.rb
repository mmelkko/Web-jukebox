class AddRoomIdToTimers < ActiveRecord::Migration
  def up
  	drop_table :timers

    create_table :timers do |t|
      t.integer :start
      t.integer :duration
      t.belongs_to :room
      t.timestamps
    end
  end

  def down
  	drop_table :timers

  	create_table :timers do |t|
      t.integer :start
      t.integer :duration

      t.timestamps
    end
  end

end
