class RemoveIsAdminFromUserDetail < ActiveRecord::Migration[5.2]
  def change
    remove_column :user_details, :is_admin, :boolean
  end
end
