class AddCurrencyToPayolaSale < ActiveRecord::Migration[7.0.4]
  def change
    add_column :payola_sales, :currency, :string
  end
end
