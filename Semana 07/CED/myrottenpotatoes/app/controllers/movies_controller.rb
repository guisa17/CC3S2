class MoviesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :handle_record_invalid

  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end 

  def create
    @movie = Movie.create!(movie_params)
    redirect_to movies_path, notice: "#{@movie.title} created."
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    @movie.update!(movie_params)
    redirect_to movie_path(@movie), notice: "#{@movie.title} updated."
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path, notice: "#{@movie.title} deleted."
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :rating, :release_date)
  end

  def handle_record_not_found
    flash[:alert] = "Movie not found."
    redirect_to movies_path
    logger.error("Movie not found with ID=#{params[:id]}")
  end

  def handle_record_invalid(exception)
    flash[:alert] = "Movie could not be created or updated: #{exception.record.errors.full_messages.join(', ')}"
    render 'new'
    logger.error("Error creating or updating movie: #{exception.message}")
  end
end
