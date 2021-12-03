class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy #foreign_key: "外部カラム"で外部キーのカラムを指定できる
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following_user, through: :follower, source: :followed #自分がフォローしている人（誰かをフォローした自分から中間テーブルを通して、自分にフォローされた人を取得する）
                                                                  #following_user:中間テーブルを通してfollowedモデルのフォローされる側を取得すること
  has_many :follower_user, through: :followed, source: :follower  #自分をフォローしている人（誰かにフォローされた自分から中間テーブルを通して、フォローしてきた人を取得する）
                                                                  #follower_user:中間テーブルを通してfollowerモデルのフォローする側を取得すること
  has_many :favorited_books, through: :favorites, source: :book
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :rooms, through: :entries
  
  attachment :profile_image, destroy: false

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true

  validates :introduction, length: {maximum: 50}

  #ユーザーをフォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end
  #ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end
  #フォローしていれば、trueを返す
  def following?(user)
    following_user.include?(user)
  end

end
