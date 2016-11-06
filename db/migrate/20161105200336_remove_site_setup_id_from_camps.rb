class RemoveSiteSetupIdFromCamps < ActiveRecord::Migration
  def change
    remove_column :camps, :site_setup_id
    add_column :site_setups, :camp_id, :integer
  end
end
