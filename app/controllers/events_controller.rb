class EventsController < ApplicationController

  def index
    if_logged_in { @events_by_year = Event.events_by_year }
  end

  def show
    if_logged_in { @event = Event.find_by_id params[:id] }
  end

  def edit
    if_logged_in { @event = Event.find_by_id params[:id] }
  end

  def update
    event = params[:event]
    puts event[:date]
    puts DateTime.new(event["date(1i)"].to_i,
                      event["date(2i)"].to_i,
                      event["date(3i)"].to_i,
                      event["date(4i)"].to_i,
                      event["date(5i)"].to_i,
                      0,
                      ((Time.zone.utc_offset / 60) / 60).to_s)
  end

end
