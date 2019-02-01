class AddAttributesToCoupons < ActiveRecord::Migration
  def change
    add_column :coupons, :app, :string
    add_column :coupons, :purchase_number, :string
  end
end
