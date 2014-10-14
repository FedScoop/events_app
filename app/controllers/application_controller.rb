class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :logged_in?, :current_user

  def logged_in?
    !!User.find_by_id(session[:user_id])
  end

  def current_user
    User.find_by_id(session[:user_id])
  end

  def not_logged_in
    flash[:message] = "You must be logged in to view that"
    redirect_to root_path
  end

  def if_logged_in(*else_if, &block)
    if else_if.first
      if logged_in?
        block.call
      elsif else_if.first
        else_if[1].call
      else
        not_logged_in
      end
    else
      if logged_in?
        block.call
      else
        not_logged_in
      end
    end
  end

end
