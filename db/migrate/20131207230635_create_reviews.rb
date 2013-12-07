class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :film
      t.text :plot
      t.string :languages
      t.string :director
      t.string :genres
      t.string :url
      t.integer :length
      t.float :rating
      t.text :plot_summary

      t.timestamps
    end
    add_index :reviews, :film_id
  end
end
