module RoomsHelper
  require 'soundcloud'

  def queue_time room
    seconds = 0
    client = SoundCloud.new(:client_id => "86898a442cab8a6489b73d3e8d927acf")
    warning = ""

    room.play_queue.songs.each do |song|
      unless song.id.nil?
        begin
          track = client.get("/tracks/#{song.soundcloud_id}")
          seconds += track.duration/1000
        rescue SoundCloud::ResponseError => e
          logger.error("***** #{e}: #{e.response} for track id #{song.soundcloud_id} ******")
          warning "at least"
        end
      end
    end

    seconds -= (Time.now.utc.to_i-@room.clock.start)
    minutes = (seconds/60).round
    hours = (minutes/60).floor

    h = ""
    if hours == 1
      h = "1 hour and"
    elsif hours > 1
      h = "#{hours} hours and"
    end

    m = ""
    if minutes == 1
      m = "1 minute"
    else
      m = "#{minutes} minutes"
    end

    return "The Queue is #{warning} #{h} #{m} long."
  end

end
