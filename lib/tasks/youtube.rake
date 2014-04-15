require 'yaml'

namespace :youtube do
    task :api => :environment do
        youtube_api_key = YAML::load(File.open("#{Rails.root}/config/api.yml"))["youtube_api_key"]
        @youtube = YouTubeIt::Client.new(:dev_key => youtube_api_key)

    end

    desc "Download links to trailers on Youtube"
    task :download_trailers => [:environment, :api] do
        force_download = ENV['FORCE'] or false
        reviews = force_download ? Review.all : Review.where(youtube_html: nil)
        reviews.each do |review|
            next if review.film.nil?
            title = review.film.title.gsub(/\A(2|3)D - /, '')
            puts "Searching for trailer: #{title}"
            video = @youtube.videos_by(:query => "#{title} trailer", :max_results => 1).videos.first
            if video
                review.youtube_html = video.embed_url
                #puts "    HTML: #{review.youtube_html}"
                review.save
            end
        end
    end
end