class AddAddressAndDurationToCinemas < ActiveRecord::Migration
  def change
    add_column :cinemas, :address, :string
    add_column :cinemas, :postcode, :string
    add_column :cinemas, :distance, :integer
    add_column :cinemas, :duration, :integer
  end
end
