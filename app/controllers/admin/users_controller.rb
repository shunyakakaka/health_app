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
      flash[:notice] = "ユーザー「#{@user.name}」を登録しました"
      redirect_to admin_users_path
    else
      redirect_to admin_new_user_path
    end
  end

  def destroy
    user = User.find(params[:id])
    flash[:notice] = "「#{user.name}」が削除されました」"
    user = User.destroy(params[:id])
    
    redirect_to admin_users_path
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    flash[:notice] = "編集しました"
    redirect_to admin_user_path(@user.id)
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
