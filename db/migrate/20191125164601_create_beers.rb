class CreateBeers < ActiveRecord::Migration[5.2]
  def change
    create_table :beers do |t|
      t.string :name
      t.string :brewery
      t.string :style
      t.string :country
      t.float :alcohol_percentage
      t.string :colour
      t.string :description
      t.integer :sweetness
      t.integer :bitterness
      t.integer :fizzing
      t.integer :strength
      t.integer :sourness

      t.timestamps
    end
  end
end
