class AddDateToPerformance < ActiveRecord::Migration
  def change
    add_column :performances, :date, :date
  end
end
