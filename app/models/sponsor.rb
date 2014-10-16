class Sponsor < ActiveRecord::Base
  has_many :sponsorships
  has_many :events, through: :sponsorships

  has_attached_file :photo, :styles => { :huge => "1000x1000#", :large => "700x700#", :medium => "300x300#", :thumb => "100x100#" }, :default_url => "/images/missing/missing_:style.jpg"
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  process_in_background :photo

end
