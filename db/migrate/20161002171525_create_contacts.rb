class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :f_name
      t.string :l_name
      t.string :title
      t.integer :address_id

      t.timestamps null: false
    end
  end
end
