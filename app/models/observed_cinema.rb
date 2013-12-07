class ObservedCinema < ActiveRecord::Base
  attr_accessible :cinema
  belongs_to :cinema
end
