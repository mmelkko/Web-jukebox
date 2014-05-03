# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
theme = Theme.create(name: "Rock'n'Roll")
queue = PlayQueue.create()
queue.songs.create(soundcloud_id: "10597436")
queue.songs.create(soundcloud_id: "106181677")
queue.songs.create(soundcloud_id: "87235678")
queue.songs.create(soundcloud_id: "18913738")
clock = Clock.create(start: Time.now, duration: "10000")
home = Room.create(theme: theme, play_queue: queue, clock: clock)
