class CommentsController < ApplicationController
  before_action :require_user_logged_in

  def create
    # ログインユーザーのみがコメントできる
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      flash[:success] = 'コメントを投稿しました。'
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = 'コメントの投稿に失敗しました。'
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
    # ログインユーザーのみが編集できる
    # 自分が投稿したコメントのみ編集できる
    @comment = current_user.comments.find(params[:id])
  end

  # ログインユーザーのみが編集できる
  def update
    @comment = current_user.comments.find(params[:id])
    @comment.update(comment_update_params)
  end

  # ログインユーザーのみが削除できる
  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
  end

  private

  # params[:comment]のcontentカラム、params[:comment]のpost_idを取得する
  # 1つのpostに対して複数のコメントが紐づいていて、それはcomment.rbが持っているpost_idで繋がっている
  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id).merge(post_id: params[:post_id]) #①
  end

  # params[:comment]のcontentカラムを取得する
  def comment_update_params
    params.require(:comment).permit(:content)
  end
end