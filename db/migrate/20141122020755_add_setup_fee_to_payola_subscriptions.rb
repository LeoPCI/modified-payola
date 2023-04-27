class AddSetupFeeToPayolaSubscriptions < ActiveRecord::Migration[7.0]
  def change
    add_column :payola_subscriptions, :setup_fee, :integer
  end
end
