class SiteSetup < ActiveRecord::Base
  belongs_to :camp

  def housing_exists
    hotel > 0 || group_local_bath > 0 || group_sep_bath > 0 || rustic > 0 || rv > 0
  end
end
