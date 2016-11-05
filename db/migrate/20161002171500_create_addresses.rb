class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :address
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.integer :lat
      t.integer :lon

      t.timestamps null: false
    end
  end
end
