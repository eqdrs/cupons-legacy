class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
      t.string :title
      t.text :description
      t.float :discount
      t.datetime :start_at
      t.datetime :end_at
      t.string :prefix
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
