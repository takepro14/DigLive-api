class CreateUserGenreMaps < ActiveRecord::Migration[6.0]
  def change
    create_table :user_genre_maps do |t|
      t.references :user, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true

      t.timestamps
    end
    add_index :user_genre_maps, [:user_id, :genre_id], unique: true
  end
end
