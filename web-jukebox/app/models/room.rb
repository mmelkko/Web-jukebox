class Room < ActiveRecord::Base
  has_one :theme, :dependent => :destroy
  accepts_nested_attributes_for :theme

  has_one :play_queue, :dependent => :destroy
  accepts_nested_attributes_for :play_queue

  attr_accessible :play_queue, :theme


  def registerSoundCloudClient()
  	# register a client with YOUR_CLIENT_ID as client_id_
  	# YOUR_CLIENT_ID = 86898a442cab8a6489b73d3e8d927acf
    client = SoundCloud.new(:client_id => "86898a442cab8a6489b73d3e8d927acf")
    # get 10 hottest tracks
    tracks = client.get('/tracks', :limit => 10, :order => 'hotness')
    # print each link
    # DOES NOT WORK
    tracks.each do |track|
      puts track.permalink_url
    end
  end

end
