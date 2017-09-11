class CampInfo < ActiveRecord::Base
  has_and_belongs_to_many :amenities
  belongs_to :camp
end
