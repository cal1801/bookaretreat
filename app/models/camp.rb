class Camp < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :address
  belongs_to :contact
  has_one :site_setup, :dependent => :destroy
  has_many :images, :dependent => :destroy
  has_many :camp_infos

  accepts_nested_attributes_for :images, :site_setup
end
