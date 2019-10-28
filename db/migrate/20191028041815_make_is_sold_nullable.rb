class MakeIsSoldNullable < ActiveRecord::Migration[5.2]
  def change
    change_column :listings, :is_sold, :boolean, null: true, default: false
  end
end
