class Fav < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  validates_uniqueness_of :movie, scope: :user, message: "This movie is already in your favorite list!!"
end
