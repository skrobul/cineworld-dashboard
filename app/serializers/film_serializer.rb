class FilmSerializer < ActiveModel::Serializer
  attributes :id, :title, :performances, :poster_url, :still_url, :edi, :cineworld_film_id, :watched#, :edi
  has_many :performances, serializer: PerformanceSerializer
  has_one :review
end
