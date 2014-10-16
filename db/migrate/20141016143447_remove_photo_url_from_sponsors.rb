class RemovePhotoUrlFromSponsors < ActiveRecord::Migration
  def change
    remove_column :sponsors, :photo_url, :string
  end
end
