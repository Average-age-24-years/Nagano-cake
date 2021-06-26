class Admin::GenresController < ApplicationController
  before_action :authenticate_admin_admin!

  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def create
    genre = Genre.new(genre_params)
    if genre.name.match(/[一-龠々]/)
      genre.conversion_name = genre.name.to_kanhira.to_roman
    elsif genre.name.is_hira? || genre.name.is_kana?
      genre.conversion_name = genre.name.to_roman
    else
      genre.conversion_name = genre.name
    end
    genre.save
    redirect_to admin_genres_path, notice: "ジャンルを登録しました"
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    genre = Genre.find(params[:id])
    genre.update(genre_params)
    redirect_to admin_genres_path, notice: "ジャンルの変更を保存しました"
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end
