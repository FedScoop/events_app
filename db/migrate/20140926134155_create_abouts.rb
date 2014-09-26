class CreateAbouts < ActiveRecord::Migration
  def change
    create_table :abouts do |t|
      t.string :homepage_text
      t.string :about_page_text

    end
  end
end
