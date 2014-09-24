class Sponsor < ActiveRecord::Base
  has_many :sponsorships
  has_many :events, through: :sponsorships

end
