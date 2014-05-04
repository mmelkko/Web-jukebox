class AddInformationToSong < ActiveRecord::Migration
  def change
    add_column :songs, :image_url, :string
    add_column :songs, :url, :string
    add_column :songs, :creator, :string
    add_column :songs, :name, :string
  end
end
