class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :address_line_1, null: false
      t.string :address_line_2
      t.string :city, null: false
      t.string :state
      t.string :postcode, null: false
      t.references :user, foreign_key: true
      t.references :country, foreign_key: true

      t.timestamps
    end
  end
end
