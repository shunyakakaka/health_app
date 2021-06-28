class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :require_admin
  before_action :login_required

  private

  def current_user
    if session[:user_id]
      @current_user = @current_user || User.find_by(id: session[:user_id])
    end
  end

  def require_admin
    unless current_user.admin?
      redirect_to root_path
    end
  end

  def login_required
    unless current_user
      redirect_to login_path
    end
  end
end
