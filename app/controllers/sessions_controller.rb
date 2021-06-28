class SessionsController < ApplicationController
  skip_before_action :login_required
  def new
    @user = User.new(flash[:user])
  end

  def create
    @user = User.find_by(name: session_params[:name])
    if @user && @user.authenticate(session_params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to root_path
    else
      flash[:user] = @user
      flash[:error_message] = "正しく入力してください"
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to boards_path
  end

  private

  def session_params
    params.require(:session).permit(:name, :password)
  end
end