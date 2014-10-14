class AgenciesController < ApplicationController

  def index
    if_logged_in { @agencies = Agency.all.order "name" }
  end

  def show
    agency = Agency.find_by_id params[:id]
    if logged_in? && agency
      @agency = agency
    elsif !agency
      flash[:message] = "Sorry, that agency / employer doesn't exist!"
      redirect_to agencies_path
    else
      not_logged_in
    end
  end

  def edit
    if_logged_in { @agency = Agency.find_by_id params[:id] }
  end

end
