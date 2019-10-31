class RemoveUsernameFromUserDetail < ActiveRecord::Migration[5.2]
  def change
    remove_column :user_details, :username, :string
  end
end
