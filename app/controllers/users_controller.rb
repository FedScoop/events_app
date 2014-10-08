class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UsersMailer.welcome_email(@user).deliver
      flash[:message] = "Please check your email to validate your account"
      redirect_to root_path
    else
      flash[:message] = "Something went wrong. Please try again."
      redirect_to new_user_path
    end
  end

  def show
    if logged_in?
      @user = User.find_by_id(params[:id])
    else
      flash[:message] = "You must log in to view that."
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :error)
  end

end
