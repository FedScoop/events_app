class SessionsController < ApplicationController
  def create
    @user = User.find_by_email(user_params[:email])
    if @user && @user.authenticate(user_params[:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:error] = "Your email or password was incorect"
      redirect_to login_path
    end
  end

  def new
    if logged_in?
      redirect_to user_path(current_user)
    else
      @user = User.new
    end
  end

  def logout
    session.clear
    flash[:message] = "You have been logged out"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
