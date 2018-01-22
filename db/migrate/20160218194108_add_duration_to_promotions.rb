class AddDurationToPromotions < ActiveRecord::Migration
  def change
    add_column :promotions, :duration, :integer
  end
end
