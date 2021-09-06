class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  before_action :set_genre, only: [:index, :new, :edit, :create, :update]
  
  def index
    @pagy, @posts = pagy(Post.order(created_at: :desc))
  end
  
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.order(created_at: :desc) 
    @comment = Comment.new 
    
  end
  
  def new
    @post = Post.new
    @comment = Comment.new
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to current_user
    else
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'posts/new'
    end
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      flash[:success] = '投稿を更新しました。'
      redirect_to @post
    else
      flash.now[:danger] = '投稿は更新されませんでした。'
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end


  private

  def post_params
    params.require(:post).permit(:content, :author, :wordby, :genre_id)
  end
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
    redirect_to root_url
    end
  end
  
  def set_genre
    @genres = Genre.all
  end
end