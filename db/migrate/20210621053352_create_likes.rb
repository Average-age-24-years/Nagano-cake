class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer :customer_id
      t.integer :product_id

      t.timestamps
    end
    add_index :likes, :id
  end
end
