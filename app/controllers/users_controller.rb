class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.validated = false
    @user.admin = false
    @user.validation_hex = SecureRandom.hex(10)
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
    user = current_user
    if logged_in? && user.validated
      @user = user
    else
      flash[:message] = "You must be logged in to view that."
      redirect_to root_path
    end
  end

  def validate
    user = User.find_by_validation_hex(params[:id])
    if !user.validated
      @user = user
      session[:user_id] = user.id
      @user.validated = true
      @user.save!
      redirect_to dashboard_path
    else
      flash[:message] = "This user has already been validated"
      redirect_to root_path
    end
  end

  def dashboard
    if_logged_in { @user = current_user }
  end

  def edit
    if_logged_in { @user = current_user }
  end

  def update
    user = current_user
    if User.update user.id, user_params
      flash[:message] = "Your profile updated successfully!"
      redirect_to user_profile_path
    else
      flash[:message]
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :error)
  end

end
