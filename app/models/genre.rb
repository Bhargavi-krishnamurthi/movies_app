class Genre < ApplicationRecord
  has_many :genre_categorizations, dependent: :destroy
  has_many :movies, through: :genre_categorizations

  validates :name, presence: true

end
