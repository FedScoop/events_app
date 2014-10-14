class Speaker < ActiveRecord::Base
  has_many :speaking_engagements
  has_many :events, through: :speaking_engagements
  belongs_to :employer, class_name: "Agency", foreign_key: "agency_id"

  def name
    return "#{self.first_name} #{self.last_name}"
  end

end
