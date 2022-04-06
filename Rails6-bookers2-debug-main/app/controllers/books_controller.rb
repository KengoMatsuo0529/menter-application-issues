class BooksController < ApplicationController

  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

  def new
    @book = Book.new
  end

  def show
    @book = Book.new
    @book_detail = Book.find(params[:id])
    @user = @book_detail.user
    @post_comment = PostComment.new
  end

  def index
    @books = Book.all.order(rate: "DESC")
    @book = Book.new
    @users = User.all
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.rate == 0
      if @book.update(book_params)
        redirect_to book_path(@book), notice: "You have updated book successfully."
      else
        render "edit"
      end
    else
      redirect_to books_path, notice: "一度付けた評価は変更できません"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def sort_book
    if params[:book][:sort] == 'new'
      @books = Book.all.order(created_at: :DESC)
    elsif params[:book][:sort] == 'hi-rated'
      @books = Book.all.order(rate: :DESC)
    else
      @books = Book.all
    end
  end
  
  def category_search
    @books = Book.category_search(params[:category])
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :user_id, :rate, :category)
  end

  def correct_user
    book = Book.find(params[:id])
    if current_user.id != book.user.id
    redirect_to books_path
    end
  end
end
