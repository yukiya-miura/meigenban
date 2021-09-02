class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :edit]
  
  def index
  end

  def show
    @user = User.find(params[:id])
    @pagy, @posts = pagy(@user.posts.order(id: :desc))
    @post = Post.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
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
    @user.update(image: nil)
  end
  
  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
end

  private

  def user_params
    params.require(:user).permit(:name, :email, :introduction, :password, :password_confirmation, :image, :content)
  end