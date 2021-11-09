class RelationshipsController < ApplicationController
  #followメソッドとunfollowメソッドはモデルで定義したものを使用
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end
end
