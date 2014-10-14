class VenuesController < ApplicationController

  def index
    if_logged_in { @venues = Venue.all.order("name") }
  end

end
