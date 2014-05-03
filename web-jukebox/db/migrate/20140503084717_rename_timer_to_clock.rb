class RenameTimerToClock < ActiveRecord::Migration
  def change
  	drop_table :timers

    create_table :clocks do |t|
      t.integer :start
      t.integer :duration
      t.belongs_to :room
      t.timestamps
    end
  end
end
