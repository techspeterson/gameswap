class RemoveForeignKeyFromUserDetail < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :user_details, column: :user_id
  end
end
