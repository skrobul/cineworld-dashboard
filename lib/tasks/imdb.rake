namespace :imdb do
    desc "Downloads meta-data for all films in a database that do not have a review yet"
    task :download => :environment do 
        Film.includes(:review).where("reviews.id" => nil).each do |film|
            puts "Searching for: #{film.title}" 
            i = Imdb::Search.new(film.title).movies.first or next
            Review.create(
                film: film,
                director: i.director.join(","),
                genres: i.genres.join(" / "),
                url: i.url,
                length: i.length,
                rating: i.rating,
                plot_summary: i.plot_summary
                )
            puts "Review for #{film.title} downloadded"
        end
    end
end