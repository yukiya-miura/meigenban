class GenresController < ApplicationController
  before_action :require_user_logged_in
  before_action :genre_list 
  
  def show
    @pagy, @posts = pagy(Post.where(genre_id: params[:id]), items: 10) 
    @genre = Genre.find(params[:id])
  end
end
