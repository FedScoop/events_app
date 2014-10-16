class AddGovieToSpeakers < ActiveRecord::Migration
  def change
    add_column :speakers, :govie, :boolean
  end
end
