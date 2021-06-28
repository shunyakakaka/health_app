class Admin::UsersController < ApplicationController
  before_action :require_admin
  
  def index
    @users = User.all 
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "ユーザー「#{@user.name}」でログインしました"
      session[:user_id] = @user.id
      redirect_to boards_path
    else
      redirect_to new_user_path
    end
  end

  def destroy
    user = User.find(params[:id])
    current_user.boards.destroy
    flash[:notice] = "「#{user.name}」が削除されました」"
    user = User.destroy(params[:id])
    
    redirect_to users_path
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.new(user_params)
    @user.update
    redirect_to user_path(@user.id)
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end

  def require_admin
    unless current_user.admin?
      redirect_to root_path
    end
  end
end