class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  before_action :genre_list 

  def index
      @posts = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(10).pluck(:post_id))
  end

  def create
    post = Post.find(params[:post_id])
    current_user.favorite(post)
    flash[:success] = 'お気に入り登録しました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    post = Post.find(params[:post_id])
    current_user.unfavorite(post)
    flash[:success] = 'お気に入りを解除しました。'
    redirect_back(fallback_location: root_path)
  end
end
