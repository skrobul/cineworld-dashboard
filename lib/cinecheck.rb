#!/usr/bin/ruby
require 'cineworld'
require 'json'
require 'pp'
require 'active_support/core_ext'

class CineChecker
	SOME_CINEMAS = {
		:hammersmith => 30,
		:feltham => 25
	}
	DEFAULT_INTERESTING_CINEMAS = [89, 25, 30, 65, 60] #Hammersmith, Feltham

	def initialize(key)
		@c = Cineworld::API.new(key)
	end

	def films_in_next_minutes(mins=10, interesting_cinemas=DEFAULT_INTERESTING_CINEMAS)
		today = DateTime.now.in_time_zone("Europe/London").strftime("%Y%m%d")
		out = {}
		seconds_to_midnight = 60 * 60 * 24 - DateTime.now.in_time_zone("Europe/London").seconds_since_midnight
		interesting_cinemas.each do |cinema|
			begin
				csymbol = Rails.cache.fetch("cached_cinema_#{cinema}", :expires_in => 100.days) do
					@c.cinemas({ :cinema => cinema })['cinemas'][0]['name']
				end
			rescue NoMethodError
				raise "API didn't return any cinemas."
			end
			out[csymbol] = {}
			# get list of EDIs played on particular date
			films =  Rails.cache.fetch("cached_films_#{cinema}", :expires_in => seconds_to_midnight) do 
				@c.films({ :cinema => cinema, :date => today, :full => true })['films']
			end

			films.each do |film|
				# from 'films' we need to resolve actual performances based on the EDI
				edi = film['edi']
				performances = Rails.cache.fetch("cached_performances_#{cinema}_#{edi}", :expires_in => seconds_to_midnight) do
					@c.performances({ :cinema => cinema, :film => edi, :date => today})['performances']
				end
				performances.each do |perf|
					london_time = DateTime.now.in_time_zone("Europe/London")
					perfdate = DateTime.strptime(perf['time'], "%H:%M")
					perfdate -= 1.hour if london_time.dst?
					if perfdate > (london_time - mins.to_i.minutes)
						out[csymbol][film] = Array.new unless out[csymbol].has_key?(film)
						out[csymbol][film] << perf['time']
					end
				end
			end
		end
		return out
	end
end

