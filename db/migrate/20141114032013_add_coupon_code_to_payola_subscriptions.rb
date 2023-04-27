class AddCouponCodeToPayolaSubscriptions < ActiveRecord::Migration[7.0]
  def change
    add_column :payola_subscriptions, :coupon, :string
  end
end
