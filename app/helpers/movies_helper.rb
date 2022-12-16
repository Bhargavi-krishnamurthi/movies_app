module MoviesHelper
	def success_state(movie)
		if movie.total_gross.present?
			if movie.low_total_gross? 
				"Flop"
			else
				number_to_currency(movie.total_gross, precision:2)
			end
		end
	end

	def movie_poster(movie, action)
		if movie.poster.attached?
			if action == "show"
				image_tag movie.poster.variant(resize_to_limit: [1000,1000])
			elsif action == "index"
				image_tag movie.poster.variant(resize_to_limit: [200,200])
			end
		else
			image_tag 'placeholder'
		end
	end

end
