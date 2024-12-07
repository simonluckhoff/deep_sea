class CreateGears < ActiveRecord::Migration[7.2]
  def change
    create_table :gears do |t|
      t.string :title
      t.text :description
      t.integer :price
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
