class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      puts "YES!"
      session[:user_id]
      redirect_to user_path(@user)
    else
      puts "NO!"
      redirect_to new_user_path
    end
  end

  def show
    @user = User.find_by_id(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :error)
  end

end
