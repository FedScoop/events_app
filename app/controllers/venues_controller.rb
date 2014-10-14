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

  def edit
    if_logged_in { @venue = Venue.find_by_id params[:id] }
  end

  def update
    venue = Venue.find_by_id params[:id]
    Venue.update venue.id, venue_params
    redirect_to venue_path(venue)
  end

  def new
    if_logged_in { @venue = Venue.new }
  end

  def create
    @venue = Venue.new(venue_params)
    if @venue.save!
      flash[:message] = @venue.name + " created successfully!"
      redirect_to venue_path(@venue)
    else
      flash[:message] = "An error occurred. Please try again."
      redirect_to new_venue_path
    end
  end

  private

  def venue_params
    params.require(:venue).permit(:name, :street, :city, :state, :zip)
  end

end
