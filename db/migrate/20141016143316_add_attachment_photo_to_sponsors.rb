class AddAttachmentPhotoToSponsors < ActiveRecord::Migration
  def self.up
    change_table :sponsors do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :sponsors, :photo
  end
end
