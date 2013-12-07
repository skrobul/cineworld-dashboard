class Film < ActiveRecord::Base
  attr_accessible :cineworld_film_id, :date, :edi, :film_url, :poster_url, :still_url, :title
  belongs_to :cinema
  has_many :performances
end
