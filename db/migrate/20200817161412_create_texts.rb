class CreateTexts < ActiveRecord::Migration[6.0]
  def change
    create_table :texts do |t|
      t.string :media
      t.string :title
      t.string :subtitle
      t.string :container
      t.string :editor
      t.string :translator
      t.integer :edition
      t.string :publisher
      t.string :pub_state
      t.string :pub_city
      t.integer :pub_year
      t.string :pub_season
      t.integer :pub_month
      t.integer :pub_day
      t.string :page_start
      t.string :page_end
      t.string :url
      t.date :accessed
      t.text :notes
    end
  end
end
