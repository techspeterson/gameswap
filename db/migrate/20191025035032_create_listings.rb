class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.string :title
      t.text :description
      t.integer :condition
      t.decimal :price
      t.boolean :is_sold
      t.references :user, foreign_key: true
      t.references :platform, foreign_key: true
      t.references :genre, foreign_key: true

      t.timestamps
    end
  end
end
