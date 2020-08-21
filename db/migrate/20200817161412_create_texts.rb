class CreateTexts < ActiveRecord::Migration[6.0]
  def change
    create_table :texts do |t|
      t.string :title
      t.string :subtitle
      t.string :editor
      t.string :translator
      t.integer :edition
      t.string :publisher
      t.string :pub_state
      t.string :pub_city
      t.integer :pub_year
      t.text :notes
    end
  end
end
