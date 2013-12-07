class CreateCinemas < ActiveRecord::Migration
  def change
    create_table :cinemas do |t|
      t.integer :id
      t.string :name

      t.timestamps
    end
  end
end
