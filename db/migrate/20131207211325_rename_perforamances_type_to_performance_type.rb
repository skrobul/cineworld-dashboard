class RenamePerforamancesTypeToPerformanceType < ActiveRecord::Migration
  def up
    rename_column :performances, :type, :performance_type
  end

  def down
    rename_column :performances, :performance_type, :type
  end
end
