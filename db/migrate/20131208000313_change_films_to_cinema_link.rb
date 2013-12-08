class ChangeFilmsToCinemaLink < ActiveRecord::Migration
  def up
    remove_column :films, :cinema_id
    create_table :cinemas_films do |t|
        t.integer :cinema_id
        t.integer :film_id
    end
  end

  def down
    drop_table :cinemas_films
    add_column :films, :cinema_id, :integer
  end
end
