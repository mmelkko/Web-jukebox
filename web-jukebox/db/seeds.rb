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

home.play_queue.songs.create(soundcloud_id: "19306001",
  image_url: "http://i1.sndcdn.com/artworks-000009442684-7zgvh4-large.jpg?61e8f21",
  url: "http://soundcloud.com/beyoncemusic/best-thing-i-never-had-dj",
  name: "Best Thing I Never Had [DJ Escape & Tony Coluccio Dub Remix]",
  creator: "Beyonce",
  duration: 367186)
home.play_queue.songs.create(soundcloud_id: "73653370",
  image_url: "http://i1.sndcdn.com/artworks-000037584432-6688t4-large.jpg?61e8f21",
  url: "http://soundcloud.com/skrillex/skrillex-scary-bolly-dub",
  name: "Skrillex - Scary Bolly Dub",
  creator: "Skrillex",
  duration: 219527)
home.play_queue.songs.create(soundcloud_id: "15188186",
  image_url: "http://i1.sndcdn.com/artworks-000007216039-ur90yq-large.jpg?61e8f21",
  url: "http://soundcloud.com/dubmatix/bob-marley-is-this-love",
  name: "Bob Marley Is this Love (Dubmatix Re-Visioned)",
  creator: "dubmatix",
  duration: 293282)
home.play_queue.songs.create(soundcloud_id: "121864561",
  image_url: "http://i1.sndcdn.com/artworks-000063700391-hph90l-large.jpg?61e8f21",
  url: "http://soundcloud.com/marckinchen/shadow-child-friday-feat-takura-mk-medicine-dub",
  name: "Shadow Child feat Takura - Friday (MK Medicine Dub)",
  creator: "MK (Marc Kinchen)",
  duration: 468993)
