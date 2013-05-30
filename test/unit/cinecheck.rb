require "test/unit"

require File.expand_path("../../../lib/cinecheck", __FILE__)
require 'cineworld'

class TestCineCheck < Test::Unit::TestCase

	def setup
		puts "Enter your API key: "
		@api_key = gets.chomp
		@c = CineChecker.new(@api_key)
	end

	def test_next_movies
		next_movies = @c.films_in_next_minutes
		assert next_movies
		assert next_movies.include?("London - Feltham")
	end
end
