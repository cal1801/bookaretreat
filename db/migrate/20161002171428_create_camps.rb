class CreateCamps < ActiveRecord::Migration
  def change
    create_table :camps do |t|
      t.string :name
      t.integer :address_id
      t.integer :contact_id
      t.string :web_url
      t.boolean :pccca_member
      t.integer :site_setup_id

      t.timestamps null: false
    end
  end
end
