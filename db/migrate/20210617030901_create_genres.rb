class CreateGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :genres do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :genres, :id
  end
end
