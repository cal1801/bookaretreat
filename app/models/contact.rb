class Contact < ActiveRecord::Base
  validates :f_name, presence: true
  validates :l_name, presence: true

  has_one :address
end
