# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
theme = Theme.create(name: "Rock'n'Roll")
song = Song.create(soundcloud_id: "222")
queue = PlayQueue.create(songs: [song])
home = Room.create(theme: theme, play_queue: queue)
