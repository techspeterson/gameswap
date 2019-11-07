class AddUserIdToUserDetail < ActiveRecord::Migration[5.2]
  def change
    remove_column :user_details, :user_id, :bigint
    add_reference :user_details, :user, foreign_key: true
  end
end
