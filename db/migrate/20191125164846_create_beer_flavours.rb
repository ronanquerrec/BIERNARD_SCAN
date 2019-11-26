class CreateBeerFlavours < ActiveRecord::Migration[5.2]
  def change
    create_table :beer_flavours do |t|
      t.references :flavour, foreign_key: true
      t.references :beer, foreign_key: true

      t.timestamps
    end
  end
end
