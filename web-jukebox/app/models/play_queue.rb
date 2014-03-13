class PlayQueue < ActiveRecord::Base
  belongs_to :room

  has_many :songs
  accepts_nested_attributes_for :songs
  
  #attr_accessible :songs_attributes
end
