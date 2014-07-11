class Changecinemadate < ActiveRecord::Migration
  def change
    remove_column :films, :date
    add_column :films, :date, :date
  end

end
