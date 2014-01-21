class Film < ActiveRecord::Base
  attr_accessible :cineworld_film_id, :date, :edi, :film_url, :poster_url, :still_url, :title, :watched
  has_and_belongs_to_many :cinemas
  has_many :performances
  has_one :review
end
