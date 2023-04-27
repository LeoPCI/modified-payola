class AddActiveToPayolaCoupon < ActiveRecord::Migration[7.0.4]
  def change
    add_column :payola_coupons, :active, :boolean, default: true
  end
end
