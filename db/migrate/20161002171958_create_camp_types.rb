class CreateCampTypes < ActiveRecord::Migration
  def change
    create_table :camp_types do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
