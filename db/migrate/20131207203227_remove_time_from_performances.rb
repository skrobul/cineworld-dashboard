class RemoveTimeFromPerformances < ActiveRecord::Migration
  def up
    remove_column :performances, :time
  end

  def down
    add_column :performances, :time, :timestamp
  end
end
