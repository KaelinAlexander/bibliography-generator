class CreateBibliographies < ActiveRecord::Migration[6.0]
  def change
    create_table :bibliographies do |t|
      t.string :name
      t.string :style
      t.string :type
      t.integer :user_id
    end
  end
end
