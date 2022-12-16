class Review < ApplicationRecord
  belongs_to :movie 
  belongs_to :user

  validates_uniqueness_of :user, scope: :movie, message: "You have already reviewed this movie!"

  RATINGS = %W(1 2 3 4 5)

  # validates :name, :comment, presence: true
  validates :comment,  length: { minimum: 4 }, presence: true
  # validates :stars, inclusion: RATINGS
  validates :stars , numericality: {less_than_or_equal_to: 5, greater_than_or_equal_to: 1,  message: "Please select a rating!" }

  scope :past_n_days, ->(n) { where("created_at >= ?" , n.days.ago) }
end
