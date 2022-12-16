class ReviewsController < ApplicationController

    before_action :set_movie, only: [:index, :new, :create, :edit, :update, :destroy]
    before_action :set_review, only: [:edit, :update, :destroy]

    def index
        # @movie = Movie.find(params[:movie_id])
        @reviews = @movie.reviews
    end

    def new
        # @movie = Movie.find(params[:movie_id])
        @review = @movie.reviews.new
    end

    def create
        # @movie = Movie.find(params[:movie_id])
        @review = @movie.reviews.new(review_params)
        @review.user = current_user
        if @review.save
            redirect_to  movie_reviews_path(@movie), notice: "Thanks for the Review!!"
        else
            render :new
        end
    end

    def edit
        # @movie = Movie.find(params[:movie_id])
        # @review = Review.find(params[:id])
    end

    def update
        # @movie = Movie.find(params[:movie_id])
        # @review = Review.find(params[:id])
        if @review.update(review_params)
          redirect_to movie_reviews_path(@movie) , notice: "Review was edited successfully!"
        else
            render :edit
        end 
    end

    def destroy
        # @movie = Movie.find(params[:movie_id])
        # @review = Review.find(params[:id])
        @review.destroy!
        redirect_to  movie_reviews_path(@movie), notice: "Review is successfully deleted."
    end

    private

    def set_movie
        @movie = Movie.find_by(slug: params[:movie_id])
    end

    def set_review
        @review = Review.find(params[:id])
    end

    def review_params
        params.require(:review).permit(:stars, :comment)
    end
end
