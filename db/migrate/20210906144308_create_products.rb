class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :code, null: false, index: { unique: true }
      t.decimal :price, null: false
      t.integer :count_for_discount
      t.decimal :discount

      t.timestamps
    end
  end
end
