class AddColumnsForUrlToCamps < ActiveRecord::Migration
  def change
    add_column :camps, :camp_desc, :string
    add_column :camps, :camp_url, :string
    add_column :camps, :staff_desc, :string
    add_column :camps, :staff_url, :string
  end
end
