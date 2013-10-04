require 'cinecheck'
require 'yaml'

task :pull_from_cineworld => :environment do
    cineworld_api_key = YAML::load(File.open("#{Rails.root}/config/api.yml"))["cineworld_api_key"]
    chdl = CineChecker.new(cineworld_api_key)
    puts chdl.films_in_next_minutes   
end