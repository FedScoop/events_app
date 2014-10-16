class AddAttachmentPhotoToSpeakers < ActiveRecord::Migration
  def self.up
    change_table :speakers do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :speakers, :photo
  end
end
