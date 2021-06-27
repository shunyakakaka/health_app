class UsersController < ApplicationController
  skip_before_action :login_required
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
      flash[:notice] = "ユーザー「#{@user.name}」を登録しました。"
      redirect_to users_path
    else
      redirect_to new_user_path
    end
  end

  def destroy
    User.delete(params[:id])
    binding.pry
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
end
