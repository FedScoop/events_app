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

  def update
    agency = Agency.find_by_id params[:id]
    Agency.update agency.id, agency_params
    redirect_to agency_url(agency)
  end

  def new
    if_logged_in { @agency = Agency.new }
  end

  def create
    agency = Agency.new agency_params
    if agency.save!
      flash[:message] = agency.name + " successfully created!"
      redirect_to agency_path(agency)
    else
      flash[:message] = "An error occurred, please try again."
      redirect_to new_agency_path
    end
  end

  private

  def agency_params
    params.require(:agency).permit(:name)
  end

end
