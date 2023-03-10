class CreateGenreCategorizations < ActiveRecord::Migration[6.1]
  def change
    create_table :genre_categorizations do |t|
      t.references :movie, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true
      t.timestamps
    end
  end
end
