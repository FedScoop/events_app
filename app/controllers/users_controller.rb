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
    if !user_params[:email].match /[^@]+@fedscoop.com/
      flash[:message] = "Email needs to be an '@fedscoop.com' address."
      redirect_to edit_user_path
    elsif User.update user.id, user_params
      flash[:message] = "Your profile updated successfully!"
      redirect_to user_profile_path
    else
      flash[:message] = "Oops, something went wrong!"
      redirect_to edit_user_path
    end
  end

  def edit_password
    if_logged_in { @user = current_user }
  end

  def update_password
    user = current_user
    if user.authenticate params[:old_password]
      User.update user.id, user_params
      flash[:message] = "Password Updated Successfully"
      redirect_to user_profile_path
    else
      flash[:message] = "Incorrect password. Try again."
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end
