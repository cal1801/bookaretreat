class CreateCampInfos < ActiveRecord::Migration
  def change
    create_table :camp_infos do |t|
      t.integer :type_id
      t.text :description
      t.string :url
      t.integer :camp_id

      t.timestamps null: false
    end
  end
end
