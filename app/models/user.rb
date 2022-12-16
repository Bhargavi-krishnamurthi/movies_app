class User < ApplicationRecord
  has_secure_password
  has_many :reviews, dependent: :destroy
  has_many :movies, through: :reviews
  has_many :favs, dependent: :destroy
  has_many :fav_movies, through: :favs, source: :movie

  validates :name, :email, :user_name, presence: true
  validates :email, uniqueness: { case_sensitive: false}
  validates :user_name, format: { without: /\s/}, uniqueness: { case_sensitive: false}
  
  scope :by_name, -> { self.order(:name)}
  scope :not_admin, -> {self.by_name.where("admin = false")}
end
