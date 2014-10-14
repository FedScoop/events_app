class SponsorsController < ApplicationController

  def index
    if_logged_in { @sponsors = Sponsor.all.order "name" }
  end

  def show
    if_logged_in { @sponsor = Sponsor.find_by_id params[:id] }
  end

  def new
    if_logged_in { @sponsor = Sponsor.new photo_url: "http://placekitten.com/g/200/200" }
  end

  def create
    sponsor = Sponsor.create sponsor_params
    if sponsor.save!
      flash[:message] = sponsor.name + " created successfully!"
      redirect_to sponsor_path(sponsor)
    else
      flash[:message] = "An error occurred. Please try again."
      redirect_to new_sponsor_path
    end
  end

  def edit
    if_logged_in { @sponsor = Sponsor.find_by_id params[:id] }
  end

  def update
    sponsor = Sponsor.find_by_id params[:id]
    Sponsor.update sponsor.id, sponsor_params
    redirect_to sponsor_path(sponsor)
  end

  private

  def sponsor_params
    params.require(:sponsor).permit(:name, :photo_url)
  end

end
