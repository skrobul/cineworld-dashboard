class ChangePerformanceTime < ActiveRecord::Migration
  def up
    add_column :performances, :time, :timestamp
    remove_column :performances, :date
  end

  def down
    remove_column :performances, :time
    add_column :performances, :date, :date
  end
end
