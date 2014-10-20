class EventsController < ApplicationController

  def index
    if_logged_in { @events_by_year = Event.events_by_year }
  end

end
