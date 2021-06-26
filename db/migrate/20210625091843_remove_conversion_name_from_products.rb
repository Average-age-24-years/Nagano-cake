class RemoveConversionNameFromProducts < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :Conversion_name, :string
  end
end
