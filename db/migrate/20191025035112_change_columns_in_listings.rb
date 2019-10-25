class ChangeColumnsInListings < ActiveRecord::Migration[5.2]
  def change
    change_column :listings, :title, :string, null: false
    change_column :listings, :condition, :integer, null: false
    change_column :listings, :price, :decimal, null: false, default: 1
    change_column :listings, :is_sold, :boolean, null: false
  end
end
