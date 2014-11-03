class Sponsorship < ActiveRecord::Base
  belongs_to :event
  belongs_to :sponsor
  validates_uniqueness_of :event_id, scope: :sponsor_id
end
