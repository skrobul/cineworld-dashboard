class AddYoutubeUrlToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :youtube_html, :text
  end
end
