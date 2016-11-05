class ChangeLatLonColumns < ActiveRecord::Migration
  def change
    change_column :addresses, :lat, :float
    change_column :addresses, :lon, :float
  end
end
