require 'cinecheck'
require 'yaml'

class KinoControllerController < ApplicationController

  def lookup_movie_plot(title)
    Imdb::Search.new(title).movies.first
  end
  def index
  	cineworld_api_key = YAML::load(File.open("#{Rails.root}/config/api.yml"))["cineworld_api_key"]
  	chdl = CineChecker.new(cineworld_api_key)
  	@movies = chdl.films_in_next_minutes
    @film_descriptions = {}
    @movies.each do |c, movie|
        @movies[c].each do |m|
            title = m.first['title']
            @film_descriptions[title] ||= Rails.cache.fetch("cached_movie_desc_#{title}", :expires_in => 2.days) do 
                ret = {}
                imdb_info = lookup_movie_plot(title) or return nil
                [:plot, :languages, :director, :genres].each do |attrib|
                    ret[attrib] = imdb_info.send(attrib)
                end
                ret
            end
        end
    end
  end
end
