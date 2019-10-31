class AddIsAdminToUserDetail < ActiveRecord::Migration[5.2]
  def change
    add_column :user_details, :is_admin, :boolean, default: false
  end
end
