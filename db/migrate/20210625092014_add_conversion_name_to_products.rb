class AddConversionNameToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :conversion_name, :string
  end
end
