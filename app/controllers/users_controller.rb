class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :edit]
  before_action :exist_user?, only: [:show, :edit,:favorites]
  before_action :genre_list
  
  def index
  end

  def show
    @user = User.find(params[:id])
    @pagy, @posts = pagy(@user.posts.order(id: :desc), items: 10)
    #@post = Post.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
    if current_user == @user
    else
      redirect_to current_user
    end

    
  end
  
  def update
    @user = User.find(params[:id])
    if current_user == @user
      if @user.update(user_params)
      flash[:success] = "ユーザ情報を更新しました。"
      redirect_to @user
      else
      flash.now[:danger] = 'ユーザの更新に失敗しました。'
      render 'edit'
      end
    else
      redirect_to root_url
    end
  end
  
  def imageclear
    @user = User.find(params[:id])
    @user.remove_image!
    @user.save
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'ユーザを登録しました。プロフィール編集画面から、アイコン、自己紹介を入力しましょう。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def destroy
    @user = User.find(params[:id]) 
    @user.destroy
    flash[:success] = 'ユーザーを削除しました。'
    redirect_to :root 
  end

  
  def favorites
    @user = User.find_by(id: params[:id])
    @pagy, @favorites = pagy(@user.like_posts)
  end
end

  private

  def user_params
    params.require(:user).permit(:name, :email, :introduction, :password, :password_confirmation, :image, :content, :remove_image)
  end
  
  def exist_user?
    unless User.find_by(id: params[:id])
        redirect_to root_url
    end
  end