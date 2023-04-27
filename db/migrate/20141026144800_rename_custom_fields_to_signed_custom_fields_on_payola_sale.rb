class RenameCustomFieldsToSignedCustomFieldsOnPayolaSale < ActiveRecord::Migration[7.0.4]
  def change
    rename_column :payola_sales, :custom_fields, :signed_custom_fields
  end
end
