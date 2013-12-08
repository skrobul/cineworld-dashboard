class AddNotifiedToFilms < ActiveRecord::Migration
  def change
    add_column :films, :notified, :boolean, :default => false
  end
end
