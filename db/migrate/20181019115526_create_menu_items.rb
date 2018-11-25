class CreateMenuItems < ActiveRecord::Migration[5.2]
  def change
    create_table :menu_items do |t|
      t.string :name, null: false
      t.text :description
      t.decimal :unit_price, precision: 6, scale: 2, default: 0.0
      t.references :category, foreign_key: false

      t.timestamps
    end
  end
end
