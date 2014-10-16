class RemovePhotoUrlFromSpeakers < ActiveRecord::Migration
  def change
    remove_column :speakers, :photo_url, :string
  end
end
