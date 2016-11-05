class AddPhoneNumberToCamps < ActiveRecord::Migration
  def change
    add_column :camps, :phone_number, :string
  end
end
