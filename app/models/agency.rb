class Agency < ActiveRecord::Base
  has_many :employees, class_name: "Speaker"

  def to_s
    self.name
  end

end
