class CommentsController < ApplicationController
  before_action :require_user_logged_in
  before_action :genre_list
  before_action :set_comment, only: [:edit]
  

  def create
    #@post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      flash[:success] = 'コメントを投稿しました。'
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = 'コメントの投稿に失敗しました。'
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
    @comment = current_user.comments.find(params[:id])
    @post = Post.find(params[:post_id])
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.find(params[:id])
    if @comment.update(comment_update_params)
      flash[:success] = 'コメントを更新しました。'
      redirect_to @post
    else
      flash.now[:danger] = 'コメントの更新に失敗しました。'
      render "edit"
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.find(params[:id])
    if @comment.destroy
      flash[:success] = 'コメントを削除しました。'
      redirect_to @post
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(post_id: params[:post_id], user_id: current_user.id)
  end

  def comment_update_params
    params.require(:comment).permit(:content)
  end
end

  private
  
  def set_comment
      unless Comment.find_by(id: params[:id], post_id: params[:post_id])
      redirect_to root_url
      end
  end