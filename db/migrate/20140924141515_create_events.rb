class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string   :name
      t.datetime :date
      t.string   :reg_url

      t.belongs_to :venue

      t.timestamps
    end
  end
end
