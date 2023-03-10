class RemoveColumnFromReviews < ActiveRecord::Migration[6.1]
  def change
    remove_column :reviews, :email, :string
    remove_column :reviews, :name, :string
    add_reference :reviews, :user, foreign_key: true
  end
end
