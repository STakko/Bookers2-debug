class Book < ApplicationRecord
	belongs_to :user
	has_many :favorites, dependent: :destroy
	has_many :book_comments, dependent: :destroy
	has_many :favorited_users, through: :favorites, source: :user
	has_many :view_counts, dependent: :destroy
	
	#scope :スコープの名前, -> {条件式}
	scope :created_today, -> { where(created_at: Time.zone.now.all_day) } #Time.zone.now.all_dayで一日を表す。（今日）
	scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) } #一日前
	scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) }#今週
	scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) }#先週
	
	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end
	
	
	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
end
