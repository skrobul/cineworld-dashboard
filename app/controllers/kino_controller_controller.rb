require 'cinecheck'
require 'yaml'

class KinoControllerController < ApplicationController
  def index
  	cineworld_api_key = YAML::load(File.open("#{Rails.root}/config/api.yml"))["cineworld_api_key"]
  	chdl = CineChecker.new(cineworld_api_key)
  	@movies = chdl.films_in_next_minutes
  end
end
