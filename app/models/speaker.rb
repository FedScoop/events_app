class Speaker < ActiveRecord::Base
  has_many :speaking_engagements
  has_many :events, through: :speaking_engagements

  def name
    return "#{self.first_name} #{self.last_name}"
  end

end
