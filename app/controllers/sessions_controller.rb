class SessionsController < ApplicationController
  def create
    @user = User.find_by_email(user_params[:email].downcase)
    if @user && @user.authenticate(user_params[:password])
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else @user
      flash[:message] = "Your email or password was incorect"
      redirect_to login_path
    # else
    #   flash[:message] = "That email address is not in our database. Make a new account here."
    #   redirect_to new_user_path
    end
  end

  def new
    if logged_in?
      redirect_to dashboard_path
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
