class CreateTimers < ActiveRecord::Migration
  def change
    create_table :timers do |t|
      t.integer :start
      t.integer :duration

      t.timestamps
    end
  end
end
