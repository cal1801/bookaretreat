class ChangeDescriptionColumnToString < ActiveRecord::Migration
  def change
    change_column :camp_infos, :description,  :string
  end
end
