class SponsorsController < ApplicationController

  def index
    if_logged_in { @sponsors = Sponsor.all.order "name" }
  end

end
