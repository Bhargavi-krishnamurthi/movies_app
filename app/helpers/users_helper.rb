module UsersHelper

    def submit_wording(user)
        if user.new_record? 
            action = "Create Account"
        else 
            action = "Update Account"
        end
    end

    # def show_reviewed_movies(user)
		# 	if user.movies.present?
		# 		content_tag(:h4, "Reviewed movies:")
		# 		content_tag(:ul) do 
		# 			user.movies.each do |movie|
		# 				content_tag(:li, movie.title.capitalize )
		# 			end 
		# 		end 
		# 	end
    # end
end


# (link_to movie.title.capitalize, movie_path(movie))