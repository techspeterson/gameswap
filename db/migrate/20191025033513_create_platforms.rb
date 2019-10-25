class CreatePlatforms < ActiveRecord::Migration[5.2]
  def change
    create_table :platforms do |t|
      t.string :name, null: false
      t.string :manufacturer
      t.integer :generation, null: false

      t.timestamps
    end
  end
end
