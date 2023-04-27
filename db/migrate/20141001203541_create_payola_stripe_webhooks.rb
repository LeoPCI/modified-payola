class CreatePayolaStripeWebhooks < ActiveRecord::Migration[7.0]
  def change
    create_table :payola_stripe_webhooks do |t|
      t.string :stripe_id

      t.timestamps
    end
  end
end
