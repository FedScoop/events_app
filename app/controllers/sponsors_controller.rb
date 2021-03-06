class SponsorsController < ApplicationController

  def index
    if_logged_in { @sponsors = Sponsor.all.order "name" }
  end

  def show
    sponsor = Sponsor.find_by_id params[:id]
    if logged_in? && sponsor
      @sponsor = sponsor
    elsif !sponsor
      flash[:message] = "Sorry, that sponsor doesn't exist!"
      redirect_to sponsors_path
    else
      not_logged_in
    end
  end

  def new
    if_logged_in { @sponsor = Sponsor.new }
  end

  def create
    sponsor = Sponsor.create sponsor_params
    if sponsor.save!
      Delayed::Worker.new.work_off
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
    if Sponsor.update sponsor.id, sponsor_params
      Delayed::Worker.new.work_off
      if params[:remove_photo]
        sponsor.photo = nil
        sponsor.save!
      end
      flash[:message] = sponsor.name + " updated successfully!"
      redirect_to sponsor_path(sponsor)
    else
      flash[:message] = "Oops, something went wrong."
      redirect_to edit_sponsor_path(sponsor)
    end
  end

  def destroy
    sponsor = Sponsor.find_by_id params[:id]
    sponsor_name = sponsor.name
    if sponsor.destroy!
      flash[:message] = sponsor_name + " was successfully deleted."
      redirect_to sponsors_path
    else
      flash[:message] = "Something went wrong."
      redirect_to sponsor_path(sponsor)
    end
  end

  private

  def sponsor_params
    params.require(:sponsor).permit(:name, :photo)
  end

end
