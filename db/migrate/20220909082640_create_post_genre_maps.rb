class CreatePostGenreMaps < ActiveRecord::Migration[6.0]
  def change
    create_table :post_genre_maps do |t|
      t.references :post, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true

      t.timestamps
    end
  end
end
