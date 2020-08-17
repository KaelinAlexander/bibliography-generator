class CreateCitations < ActiveRecord::Migration[6.0]
  def change
    create_table :citations do |t|
      t.string :location
      t.string :type
      t.integer :bibliography_id
      t.integer :text_id
    end
  end
end
