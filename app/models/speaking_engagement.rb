class SpeakingEngagement < ActiveRecord::Base
  belongs_to :speaker
  belongs_to :event
end
