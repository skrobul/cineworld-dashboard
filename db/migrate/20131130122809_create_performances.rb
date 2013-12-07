class CreatePerformances < ActiveRecord::Migration
  def change
    create_table :performances do |t|
      t.integer :film_id
      t.integer :cinema_id
      t.timestamp :time
      t.string :type
      t.string :booking_url

      t.timestamps
    end
  end
end
