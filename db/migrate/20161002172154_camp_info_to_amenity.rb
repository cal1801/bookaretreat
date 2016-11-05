class CampInfoToAmenity < ActiveRecord::Migration
  def change
    create_table :camp_infos_to_amenities do |t|
      t.integer :camp_id
      t.integer :amenity_id
    end
  end
end
