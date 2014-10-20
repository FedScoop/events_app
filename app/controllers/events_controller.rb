class EventsController < ApplicationController

  def index
    if_logged_in { @events_by_year = Event.events_by_year }
  end

  def show
    if_logged_in { @event = Event.find_by_id params[:id] }
  end

end
