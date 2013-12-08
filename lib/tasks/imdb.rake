namespace :imdb do
    desc "Downloads meta-data for all films in a database that do not have a review yet"
    task :download => :environment do 
        Film.includes(:review).where("reviews.id" => nil).each do |film|
            parsed_title = film.title.gsub(/\A(2|3)D - /, '')
            puts "Searching for: #{parsed_title}" 
            i = Imdb::Search.new(parsed_title).movies.first or next
            Review.create(
                plot: i.plot,
                film: film,
                director: i.director.join(","),
                genres: i.genres.join(" / "),
                url: i.url,
                length: i.length,
                rating: i.rating,
                plot_summary: i.plot_summary,
                trailer_url: i.trailer_url
                )
            puts "Review for #{film.title} downloadded"
        end
    end
end