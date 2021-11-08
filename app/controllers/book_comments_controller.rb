class BookCommentsController < ApplicationController
  before_action :ensure_correct_user, only: [:destroy]
  
  def create
    @book = Book.find(params[:book_id])
    comment = BookComment.new(book_comment_params)
    comment.user_id = current_user.id
    comment.book_id = @book.id
    if comment.save
      redirect_to book_path(@book)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
    redirect_to book_path(params[:book_id])
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

  def ensure_correct_user
    @book_comment = BookComment.find(params[:id])
    unless @book_comment.user == current_user
      redirect_to books_path
    end
  end
  
end