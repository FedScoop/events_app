class Event < ActiveRecord::Base
  has_many :speaking_engagements
  has_many :sponsorships
  has_many :speakers, through: :speaking_engagements
  has_many :sponsors, through: :sponsorships
  belongs_to :venue

end
