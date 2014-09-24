class CreateSponsorships < ActiveRecord::Migration
  def change
    create_table :sponsorships do |t|
      t.belongs_to :event
      t.belongs_to :sponsor
      t.string     :level

      t.timestamps
    end
  end
end
