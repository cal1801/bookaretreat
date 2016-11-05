class ChangeTypeIdToString < ActiveRecord::Migration
  def change
    rename_column :camp_infos, :type_id, :camp_type
    change_column :camp_infos, :camp_type,  :string
  end
end
