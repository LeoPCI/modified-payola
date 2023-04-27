class AddGuidToPayolaSubscriptions < ActiveRecord::Migration[7.0.4]
  def change
    add_column :payola_subscriptions, :guid, :string, limit: 191
    add_index :payola_subscriptions, :guid
  end
end
