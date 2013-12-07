class AddCinemaToFilm < ActiveRecord::Migration
  def change
    add_column :films, :cinema_id, :integer
  end
end
