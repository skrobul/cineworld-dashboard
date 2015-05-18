require 'yaml'

namespace :youtube do
    task :api => :environment do
        youtube_api_key = ENV['YOUTUBE_API_KEY'] || YAML::load(File.open("#{Rails.root}/config/api.yml"))["youtube_api_key"]
        Yt.configuration.api_key = youtube_api_key
        @videos = Yt::Collections::Videos.new
    end

    desc "Download links to trailers on Youtube"
    task :download_trailers => [:environment, :api] do
        force_download = ENV['FORCE'] or false
        reviews = force_download ? Review.all : Review.where(youtube_html: nil)
        reviews.each do |review|
            next if review.film.nil?
            title = review.film.title.gsub(/\A(2|3)D - /, '')
            puts "Searching for trailer: #{title}"
            video = @videos.where(q: "#{title} trailer", video_category_id: 44, region_code: 'GB').first
            if video
                review.youtube_html = "http://www.youtube.com/v/#{video.id}&feature=youtube_gdata_player"
                #puts "    HTML: #{review.youtube_html}"
                review.save
            end
        end
    end
end
