class ChangeIsSoldColumn < ActiveRecord::Migration[5.2]
  def change
    change_column :listings, :is_sold, :boolean, null: false, default: false
  end
end
