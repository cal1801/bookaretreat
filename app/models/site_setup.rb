class SiteSetup < ActiveRecord::Base
  belongs_to :camp

  def housing_exists
    hotel.to_i > 0 || group_local_bath.to_i > 0 || group_sep_bath.to_i > 0 || rustic.to_i > 0 || rv.to_i > 0
  end
end
