class Speaker < ActiveRecord::Base
  has_many :speaking_engagements
  has_many :events, through: :speaking_engagements

end
