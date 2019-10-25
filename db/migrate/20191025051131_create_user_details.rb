class CreateUserDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :user_details do |t|
      t.string :username, null: false
      t.text :bio
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
