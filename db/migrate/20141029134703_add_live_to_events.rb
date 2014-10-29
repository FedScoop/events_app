class AddLiveToEvents < ActiveRecord::Migration
  def change
    add_column :events, :live, :boolean
  end
end
