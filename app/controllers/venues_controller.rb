class VenuesController < ApplicationController

  def index
    if_logged_in { @venues = Venue.all.order("name") }
  end

  def show
    venue = Venue.find_by_id params[:id]
    if logged_in? && venue
      @venue = venue
    elsif !venue
      flash[:message] = "Sorry, that venue doesn't exist!"
      redirect_to venues_path
    else
      not_logged_in
    end
  end

end
