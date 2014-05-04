# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

home = Room.find_or_create_by_id(id: 1) do |room|
	clock = Clock.create(start: "0", duration: "0")
	theme = Theme.create(name: "Rock'n'Roll")
	queue = PlayQueue.create()
	room.theme = theme
	room.play_queue = queue
	room.clock = clock
end

home.play_queue.songs.create(soundcloud_id: "106181677", image_url: "http://i1.sndcdn.com/avatars-000000011308-xq0whu-large.jpg?b17c165")
home.play_queue.songs.create(soundcloud_id: "87235678")
home.play_queue.songs.create(soundcloud_id: "18913738")
home.play_queue.songs.create(soundcloud_id: "123214393")
