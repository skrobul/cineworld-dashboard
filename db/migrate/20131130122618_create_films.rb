class CreateFilms < ActiveRecord::Migration
  def change
    create_table :films do |t|
      t.integer :edi
      t.string :title
      t.integer :cineworld_film_id
      t.string :poster_url
      t.string :still_url
      t.string :film_url
      t.integer :date

      t.timestamps
    end
  end
end
