class AddSitesToCamps < ActiveRecord::Migration
  def change
    add_column :camps, :bar, :boolean, :default => true
    add_column :camps, :str, :boolean, :default => true
    add_column :camps, :bsy, :boolean, :default => true
  end
end
