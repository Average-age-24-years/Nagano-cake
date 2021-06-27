class AddConversionNameToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :Conversion_name, :string
  end
end
