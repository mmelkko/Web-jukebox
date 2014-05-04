class RenameTimerToClock < ActiveRecord::Migration
  def up
  	drop_table :timers

    create_table :clocks do |t|
      t.integer :start
      t.integer :duration
      t.belongs_to :room
      t.timestamps
    end
  end

  def down
  	create_table :timers do |t|
      t.integer :start
      t.integer :duration
      t.belongs_to :room
      t.timestamps
    end

    drop_table :clocks
  end
end
