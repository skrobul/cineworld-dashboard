class FixObserved < ActiveRecord::Migration
  def change
    add_column :observed_cinemas, :cinema_id, :integer
  end

end
