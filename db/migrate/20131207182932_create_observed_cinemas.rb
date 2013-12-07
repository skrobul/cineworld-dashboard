class CreateObservedCinemas < ActiveRecord::Migration
  def change
    create_table :observed_cinemas do |t|
      t.references :cinema_id

      t.timestamps
    end
  end
end
