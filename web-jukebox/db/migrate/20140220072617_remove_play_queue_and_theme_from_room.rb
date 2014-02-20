class RemovePlayQueueAndThemeFromRoom < ActiveRecord::Migration
  def change
    remove_column :rooms, :play_queue, :integer
    remove_column :rooms, :theme, :integer
  end
end
