class AddPlayQueueAndThemeToRoom < ActiveRecord::Migration
  def change
    add_column :rooms, :play_queue, :integer
    add_column :rooms, :theme, :integer
  end
end
