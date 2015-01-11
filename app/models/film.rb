class Film < ActiveRecord::Base
  attr_accessible :cineworld_film_id, :date, :edi, :film_url, :poster_url, :still_url, :title, :watched
  has_and_belongs_to_many :cinemas
  has_many :performances
  has_one :review
  scope :name_exclude, ->(name) { where("title NOT LIKE ?", "%#{name}%")}
  scope :notification_candidates, -> { where(notified: false)
                                       .name_exclude('Hindi')
                                       .name_exclude('Tamil')
                                       .name_exclude('Punjab')
                                       .name_exclude('Bollywood')
  }

end
