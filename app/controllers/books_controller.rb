class BooksController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
    @currentRoomUser = Entry.where(user_id: current_user.id)  #current_userが既にルームに参加しているか判断
    @receiveUser = Entry.where(user_id: @book.user.id)  #他の@userがルームに参加しているか判断

    unless @book.user.id == current_user.id  #current_userと@book.userが一致していなければ
      @currentRoomUser.each do |cu|    #current_userが参加していルームを取り出す
        @receiveUser.each do |u|    #@userが参加しているルームを取り出す
          if cu.room_id == u.room_id    #current_userと@userのルームが同じか判断(既にルームが作られているか)
            @haveRoom = true    #falseの時(同じじゃない時)の条件を記述するために変数に代入
            @roomId = cu.room_id   #ルームが共通しているcurrent_userと@userに対して変数を指定
          end
        end
      end
      unless @haveroom    #ルームが同じじゃなければ
        #新しいインスタンスを生成
        @room = Room.new
        @RoomUser = Entry.new
        #//新しいインスタンスを生成
      end
    end
    @book_detail = Book.find(params[:id])
    unless ViewCount.find_by(user_id: current_user.id, book_id: @book_detail.id)
      current_user.view_counts.create(book_id: @book_detail.id)
    end
  end

  def index
    @book = Book.new
    @books = Book.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
    @users = User.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end



  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end

end
