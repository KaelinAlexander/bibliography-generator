class CreateTexts < ActiveRecord::Migration[6.0]
  def change
    create_table :texts do |t|
      t.string :title
      t.string :subtitle
      t.string :publisher
      t.integer :pub_year
      t.text :notes
    end
  end
end
