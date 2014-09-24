class CreateSpeakingEngagements < ActiveRecord::Migration
  def change
    create_table :speaking_engagements do |t|
      t.belongs_to :speaker
      t.belongs_to :event

      t.timestamps
    end
  end
end
