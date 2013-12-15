class AddWatchedToFilms < ActiveRecord::Migration
  def change
    add_column :films, :watched, :boolean, :default => false
  end
end
