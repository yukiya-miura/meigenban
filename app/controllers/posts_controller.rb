class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def index
    @pagy, @posts = pagy(Post.all)
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

  def destroy
    @post.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end


  private

  def post_params
    params.require(:post).permit(:content, :author, :wordby)
  end
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
    redirect_to root_url
    end
  end
end