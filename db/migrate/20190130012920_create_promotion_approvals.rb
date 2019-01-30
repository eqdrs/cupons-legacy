class CreatePromotionApprovals < ActiveRecord::Migration
  def change
    create_table :promotion_approvals do |t|
      t.references :user, index: true, foreign_key: true
      t.references :promotion, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
