class GenresController < ApplicationController
  before_action :require_user_logged_in
  before_action :genre_list 
  
  def show
    @pagy, @posts = pagy(Post.where(genre_id: params[:id]).order(created_at: :desc), items: 10) 
    unless @genre = Genre.find_by(id: params[:id])
      redirect_to root_url
    end
  end
end
