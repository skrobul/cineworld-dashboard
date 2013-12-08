class AddTrailerToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :trailer_url, :string
  end
end
