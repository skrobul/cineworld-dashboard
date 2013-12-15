require 'mycineworld'
require 'yaml'

def calculate_timestamp(date, time)
    raise "Incorrect time format" unless time =~ /\A\d{2}:\d{2}\z/
    t = time.split(":").map{|e| e.to_i}
    DateTime.new(date.year, date.month, date.day, t[0], t[1], 0)
end


namespace :cineworld do
    task :initialize_cineworld_api => :environment do 
        cineworld_api_key = YAML::load(File.open("#{Rails.root}/config/api.yml"))["cineworld_api_key"]
        @cineworld = MyCineworld.new(cineworld_api_key)
    end


    desc "Queries Cineworld API for list of all available cinemas"
    task :pull_list_of_cinemas => [:environment, :initialize_cineworld_api] do
        all_cinemas = @cineworld.cinemas(:territory => 'GB')['cinemas']
        all_cinemas.each do |cinema|
            myc = Cinema.where(:id => cinema['id']).first_or_create
            myc.name = cinema['name']
            myc.save
        end
    end

    desc "Query list of films scheduled in all observed cinemas"
    task :films => [:environment, :initialize_cineworld_api] do
        today = Date.today.strftime("%Y%m%d")
        ObservedCinema.all.each do |oc|
            processed_films = 0
            @cineworld.films(:cinema => oc.cinema_id, :date => today, :full => true)['films'].each do |film|
                #puts "Processing: #{film}"
                myfilm = Film.where(
                    :cineworld_film_id => film['id'].to_i,
                    :edi => film['edi'],
                    :title => film['title']
                    ).first_or_create(
                        :film_url => film['film_url'],
                        :still_url => film['still_url'],
                        :poster_url => film['poster_url']
                    )
                unless myfilm.cinemas.include?(oc.cinema)
                    #:cinema_id => oc.cinema_id,
                    puts "Added: #{myfilm.title} to #{oc.cinema.name}"
                    myfilm.cinemas << oc.cinema
                end
                processed_films += 1
            end
            puts "Processed: #{processed_films} films for #{oc.cinema.name}" unless oc.cinema.nil?
        end
    end

    desc "Query list of performances for todays show in all observed cinemas"
    task :performances => [:films] do
        today = Date.today.strftime("%Y%m%d")
        processed_performances = 0
        Film.all.each do |film|
            film.cinemas.each do |cinema|
                cperformances = @cineworld.performances(
                    :cinema => cinema.id,
                    :film => film.edi,
                    :date => today
                )['performances']
                cperformances.each do |perf|
                    cperf = Performance.where(
                        :film_id => film.id,
                        :cinema_id => cinema.id,
                        :time => calculate_timestamp(Date.today, perf['time'])
                    ).first_or_create(
                        :booking_url => perf['booking_url'],
                        :performance_type => perf['type']
                    )
                    processed_performances += 1
                end
            end
        end
        puts "Processed #{processed_performances} total performances"
    end
end