desc "Downloads all information from external sites (Cineworld, IMDB, Youtube)"
task :refresh_external_data => ["cineworld:performances", "imdb:download", "youtube:download_trailers"] do 
    puts "All external information downloaded"
end
