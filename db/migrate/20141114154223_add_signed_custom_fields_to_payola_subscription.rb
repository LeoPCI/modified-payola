class AddSignedCustomFieldsToPayolaSubscription < ActiveRecord::Migration[7.0.4]
  def change
    add_column :payola_subscriptions, :signed_custom_fields, :text
  end
end
