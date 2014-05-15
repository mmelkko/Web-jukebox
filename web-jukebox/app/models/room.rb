class Room < ActiveRecord::Base
  has_one :theme, :dependent => :destroy
  accepts_nested_attributes_for :theme

  has_one :clock, :dependent => :destroy
  accepts_nested_attributes_for :clock

  has_one :play_queue, :dependent => :destroy
  accepts_nested_attributes_for :play_queue
  
end