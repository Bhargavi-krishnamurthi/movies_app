class Movie < ApplicationRecord

	has_many :reviews, dependent: :destroy
	has_many :favs, dependent: :destroy
	has_many :users, through: :favs
	has_many :genre_categorizations, dependent: :destroy
	has_many :genres, through: :genre_categorizations

	RATINGS = %w(G PG PG-13 R NC-17)

	validates :title, :released_on, :duration, presence: true
	validates :description , length: { minimum: 25 }
	validates :total_gross, numericality: { greater_than_or_equal_to: 0 }
	# validates :image_file_name, format: { with: /\w+\.(jpg|png)\z/i, message: "Must be a PNG or JPG file" }
	validates :rating, inclusion: RATINGS 

	scope :released, -> { where("released_on < ?", Time.now).order("released_on desc") }
	scope :upcoming, -> { where("released_on > ?", Time.now).order("released_on asc") }
	scope :recent, -> { released.limit(4) }
	scope :hit, -> { where("total_gross > ?", 300000000) }
	scope :flop, -> { where("total_gross < ?", 225000000) }

	has_one_attached :poster
	validate :acceptable_poster

	before_save :set_slug

	def set_slug
		self.slug = to_param
	end

	def low_total_gross?
		total_gross < 225000000
	end

	def average_stars
		Review.where(movie_id: self.id).average(:stars)
	end

	def cult_movie?
		self.reviews.size > 6 && average_stars >= 0.4
	end

	def fav_count
		favs.count
	end

	def favoured_by?(user)
		favs.exists?(user: user)
	end

	def to_param
		title.parameterize
	end

	private
	def acceptable_poster
		return unless poster.attached?
		if poster.byte_size >= 1.megabyte
			errors.add(:poster, "file size is too big to upload")
		end

		acceptable_poster_type = ["image/jpeg", "image/png"]
		unless acceptable_poster_type.include? poster.content_type
			errors.add(:poster, "must be a jpg or png file")
		end
	end



	
	# def self.released
	# 	where("released_on < ?", Time.now)
	# end

	# def self.hit_movies
	# 	where("total_gross > ?", 300000000)
	# end
	
	# def self.flop_movies
	# 	where("total_gross < ?", 225000000)
	# end

	# def self.recently_added
	# 	order("released_on desc").limit(3)
	# end

	# def self.upcoming
	# 	where("released_on > ?", Time.now)
	# end

end
