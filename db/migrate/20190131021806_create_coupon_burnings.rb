class CreateCouponBurnings < ActiveRecord::Migration
  def change
    create_table :coupon_burnings do |t|
      t.references :coupon, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string :reason

      t.timestamps null: false
    end
  end
end
