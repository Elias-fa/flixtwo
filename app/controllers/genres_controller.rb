class GenresController < ApplicationController
  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]

    def index
      @genres = Genre.all
    end

    def show
      @genre = Genre.find(params[:id])
      @movies = @genre.movies
    end

    def new
      @genre = Genre.new
    end

    def edit
    end

    def create
      @genre = Genre.new(genre_params)
      if @genre.save
        redirect_to @genre, notice: "Genre successfully created!"
      else
        render :new
      end
    end

    def destroy
      @genre = Genre.find(params[:id])
      @genre.destroy
      redirect_to genres_path, alert: "Genre successfully deleted!"
    end

  private

    def genre_params
      params.require(:genre).
        permit(:name)
    end

end
