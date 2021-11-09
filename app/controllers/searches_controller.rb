class SearchesController < ApplicationController
  def index
    @books = Book.all
    @books = @books.where('title LIKE ?', "%#{params[:search]}%") if params[:search].present?
  end
end