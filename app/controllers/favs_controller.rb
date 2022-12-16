class FavsController < ApplicationController
  before_action :require_sign_in, only: [:create]

  def create
    @movie = Movie.find_by(slug: params[:movie_id])
    @movie.favs.new(user: current_user)
    @movie.save
    redirect_to movie_path(@movie)
  end

  def destroy
    # @fav = Fav.find(params[:id])
    # @movie = Movie.find_by(id: @fav.movie_id)
    # @fav.destroy
    # redirect_to movie_path(@movie)

    @movie = Movie.find_by(slug: params[:id])
    @fav = Fav.find_by(movie: @movie, user: current_user)
    @fav.destroy
    redirect_to movie_path(@movie)
  end
end
