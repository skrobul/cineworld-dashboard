class Review < ActiveRecord::Base
  belongs_to :film
  attr_accessible :director, :genres, :languages, :length, :plot, :plot_summary, :rating, :url, :film, :trailer_url
end
