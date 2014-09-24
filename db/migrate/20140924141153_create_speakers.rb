class CreateSpeakers < ActiveRecord::Migration
  def change
    create_table :speakers do |t|
      t.string :first_name
      t.string :last_name
      t.string :job_title
      t.string :employer
      t.string :suffix
      t.string :photo_url

      t.timestamps
    end
  end
end
