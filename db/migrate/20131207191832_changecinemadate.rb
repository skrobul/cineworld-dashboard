class Changecinemadate < ActiveRecord::Migration
  def change
    remove_column :films, :date, :integer
    add_column :films, :date, :date
  end

end
