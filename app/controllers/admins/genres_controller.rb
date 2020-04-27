class Admins::GenresController < ApplicationController
  before_action :authenticate_admin!

def index
	@genre = Genre.new
	@genres = Genre.all
end

def create
	@genre = Genre.new(genre_params)
	if @genre.save
	redirect_to admins_genres_path
  else
  @genre = Genre.new
  @genres = Genre.all
  render 'index'
  end
end

def edit
	@genre = Genre.find(params[:id])
end

def update
	@genre = Genre.find(params[:id])
      if @genre.update(genre_params)
      redirect_to admins_genres_path(@genre)
      else
      render 'edit'
      end
end

private
  def genre_params
      params.require(:genre).permit(:genre_id, :name, :status)
  end

end