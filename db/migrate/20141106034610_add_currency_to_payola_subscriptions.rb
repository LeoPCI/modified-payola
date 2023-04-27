class AddCurrencyToPayolaSubscriptions < ActiveRecord::Migration[7.0.4]
  def change
    add_column :payola_subscriptions, :currency, :string
    add_column :payola_subscriptions, :amount, :integer
  end
end
