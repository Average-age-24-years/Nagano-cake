class CreateDistinations < ActiveRecord::Migration[5.2]
  def change
    create_table :distinations do |t|
      t.integer :customer_id,  null: false
      t.string :name,          null: false
      t.string :postal_code,   null: false
      t.string :address,       null: false

      t.timestamps
    end
    add_index :distinations, :id
  end
end
