class AddUniqueIndexToCitations < ActiveRecord::Migration[6.0]
  def change
    add_index :citations, [:bibliography, :text], unique: true
  end
end
