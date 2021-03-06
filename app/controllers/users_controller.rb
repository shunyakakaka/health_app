class UsersController < ApplicationController
  skip_before_action :login_required

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new(flash[:user])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "ユーザー「#{@user.name}」でログインしました"
      session[:user_id] = @user.id
      redirect_to boards_path
    else
      flash[:user] = @user
      flash[:error_message] = @user.errors.full_messages 
      redirect_to new_user_path
    end
  end

  def destroy
    user = User.find(params[:id])
    current_user.boards.destroy
    flash[:notice] = "「#{user.name}」が削除されました」"
    user = User.destroy(params[:id])
    
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
end
