class MoviesController < ApplicationController

  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  add_flash_types :notice, :alert
  before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]

  def index
    # @movies = Movie.all
    # puts "Query: #{Movie.released.to_sql}" 
    filter = params[:filter]
    case filter
    when "upcoming"
      @movies = Movie.upcoming
    when "recent"
      @movies = Movie.recent
    else
      @movies = Movie.released
    end

  end

  def show
    # @movie = Movie.find(params[:id])
    @review = @movie.reviews.new
    
  end

  def edit
    # @movie = Movie.find(params[:id])
  end

  def update
    # @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      flash[:notice] = "Movie updated successfully!"
      redirect_to @movie
    else
      render :edit
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, notice: "Movie created successfully!"
    else
      render :new
    end
  end

  def destroy
    # @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path, alert: "Movie is deleted"
  end


  private

  def set_movie
    @movie = Movie.find_by(slug: params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :total_gross, :released_on, :director, :duration, :poster, genre_ids: [])
  end
end
