class AddStripeCustomerIdToSale < ActiveRecord::Migration[7.0]
  def change
    add_column :payola_sales, :stripe_customer_id, :string, limit: 191
    add_index :payola_sales, :stripe_customer_id
  end
end
