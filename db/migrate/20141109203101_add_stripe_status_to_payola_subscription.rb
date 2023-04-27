class AddStripeStatusToPayolaSubscription < ActiveRecord::Migration[7.0.4]
  def change
    add_column :payola_subscriptions, :stripe_status, :string
  end
end
