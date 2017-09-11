class Camp < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged]
  validates :name, presence: true

  has_one :address, :dependent => :destroy
  belongs_to :contact
  has_one :site_setup
  has_many :images, :dependent => :destroy
  has_one :camp_info

  accepts_nested_attributes_for :images, :site_setup, :address, :camp_info
end
