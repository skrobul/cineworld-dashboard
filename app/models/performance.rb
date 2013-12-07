class Performance < ActiveRecord::Base
  attr_accessible :booking_url, :cinema, :film, :time, :type, :date
  belongs_to :film
  belongs_to :cinema
end
