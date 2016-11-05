class CreateSiteSetups < ActiveRecord::Migration
  def change
    create_table :site_setups do |t|
      t.integer :hotel
      t.integer :group_local_bath
      t.integer :group_sep_bath
      t.integer :rustic
      t.integer :rv

      t.timestamps null: false
    end
  end
end
