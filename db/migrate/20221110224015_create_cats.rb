class CreateCats < ActiveRecord::Migration[7.0]
  def change
    create_table :cats do |t|
      t.string :name
      t.string :breed
      t.text :favorite_quote

      t.timestamps
    end
  end
end
