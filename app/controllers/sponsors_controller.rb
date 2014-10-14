class SponsorsController < ApplicationController

  def index
    if_logged_in { @sponsors = Sponsor.all.order "name" }
  end

  def show
    if_logged_in { @sponsor = Sponsor.find_by_id params[:id] }
  end

end
