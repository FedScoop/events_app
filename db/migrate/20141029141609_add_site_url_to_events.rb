class AddSiteUrlToEvents < ActiveRecord::Migration
  def change
    add_column :events, :site_url, :string
  end
end
