class AddConversionNameToGenres < ActiveRecord::Migration[5.2]
  def change
    add_column :genres, :conversion_name, :string
  end
end
