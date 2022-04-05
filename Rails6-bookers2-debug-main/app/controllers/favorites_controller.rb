class FavoritesController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    favorite = Favorite.new(book_id: book.id)
    favorite.user_id = current_user.id
    favorite.save
    redirect_to request.referer
  end

  def destroy
    book = Book.find(params[:book_id])
    user = current_user
    favorite = user.favorites.find_by(params[:book_id])
    favorite.destroy
    redirect_to request.referer
  end
end
