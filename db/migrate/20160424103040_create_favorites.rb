class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.integer :first_id
      t.integer :second_id
      t.timestamps null: false
    end

    add_index :favorites, :first_id
    add_index :favorites, :second_id
    add_index :favorites, [:first_id, :second_id], unique: true

  end
end
