class AboutController < ApplicationController

  def index
    @speakers = Speaker.all.limit 8
    @next_event = Event.where('date > ?', DateTime.now).order("date").first
    events = Event.where('date > ?', DateTime.now).order("date")
    @events_this_year = events.inject([]) { |arr, event| arr << event if event.date.year == DateTime.now.year }
    @about = About.first.homepage_text
  end
end
