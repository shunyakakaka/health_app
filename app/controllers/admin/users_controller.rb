class Admin::UsersController < ApplicationController
  before_action :require_admin
  before_action :user_find_params_id, only: [:show, :destroy]

  def index
    @users = User.all 
  end

  def show
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
    flash[:notice] = "「#{@user.name}」が削除されました」"
    @user.destroy
    
    redirect_to admin_users_path
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

  def user_find_params_id
    @user = User.find(params[:id])
  end
end
