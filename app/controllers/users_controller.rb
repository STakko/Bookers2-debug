class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @following_users = @user.following_user
    @follower_users = @user.follower_user
    @today_book = @books.created_today
    @yesterday_book = @books.created_yesterday
    @this_week_book = @books.created_this_week
    @last_week_book = @books.created_last_week
    @two_days_ago_book = @books.created_two_days_ago
    @three_days_ago_book = @books.created_three_days_ago
    @four_days_ago_book = @books.created_four_days_ago
    @five_days_ago_book = @books.created_five_days_ago
    @six_days_ago_book = @books.created_six_days_ago
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render:edit
    else @user = current_user
      redirect_to user_path(@user.id)
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  #フォロー一覧ページ用
  def follows
    @user = User.find(params[:id])
    @users = @user.following_user
  end

  #フォロワー一覧ページ用
  def followers
    @user = User.find(params[:id])
    @users = @user.follower_user
  end

  def day_search
    @user = User.find(params[:user_id])#なぜ:idではなく:user_idなのか？
    @books = @user.books
    @book = Book.new
    if params[:created_at] == ""#空欄の場合、下の文章を表示する
      @search_book = "日付を指定して下さい"
    else
      created_at = params[:created_at]
      @search_book = @books.where(['created_at LIKE ?', "#{created_at}%"]).count #whereでヒットした投稿をカウントする
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
