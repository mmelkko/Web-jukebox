class Room < ActiveRecord::Base
  has_one :theme, :dependent => :destroy
  accepts_nested_attributes_for :theme

  has_one :queue, :dependent => :destroy
  accepts_nested_attributes_for :queue
end
