class Speaker < ActiveRecord::Base
  has_many :speaking_engagements
  has_many :events, through: :speaking_engagements
  belongs_to :employer, class_name: "Agency", foreign_key: "agency_id"

  has_attached_file :photo, :styles => { :huge => "1000x1000#", :large => "700x700#", :medium => "300x300#", :thumb => "100x100#" }, :default_url => "/images/missing/missing_:style.jpg"
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  process_in_background :photo

  def name
    return "#{self.first_name} #{self.last_name}"
  end

end
