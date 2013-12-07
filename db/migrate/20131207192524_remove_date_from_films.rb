class RemoveDateFromFilms < ActiveRecord::Migration
  def up
    remove_column :films, :date, :date
  end

  def down
    add_column :films, :date, :date
  end
end
