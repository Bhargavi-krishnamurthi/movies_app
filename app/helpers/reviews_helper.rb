module ReviewsHelper

  def average_rating(movie)
		if movie.reviews.present?
			if movie.average_stars > 0
				content_tag(:h5, number_with_precision(movie.average_stars, precision: 2)) 
			end
		else
			content_tag(:h5, "No Reviews yet!")
		end
	end

	def calculate_stars(review)
		review.stars.times { print "⭐"}
	end

end
