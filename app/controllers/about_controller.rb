class AboutController < ApplicationController

  # def initialize
  #   @next_event = Event.where('date > ?', DateTime.now).order("date").first
  #   events = Event.where('date > ?', DateTime.now).order("date")
  #   @events_this_year = events.inject([]) { |arr, event| arr << event if event.date.year == DateTime.now.year }
  # end

  def index
    @speakers = Speaker.all.limit 8
    @next_event = Event.where('date > ?', DateTime.now).order("date").first
    events = Event.where('date > ?', DateTime.now).order("date")
    @events_this_year = events.inject([]) { |arr, event| arr << event if event.date.year == DateTime.now.year }
    @about = About.first.homepage_text
  end

  def speakers
    @speakers = Speaker.all
    @next_event = Event.where('date > ?', DateTime.now).order("date").first
    events = Event.where('date > ?', DateTime.now).order("date")
    @events_this_year = events.inject([]) { |arr, event| arr << event if event.date.year == DateTime.now.year }
  end

  def about
    @next_event = Event.where('date > ?', DateTime.now).order("date").first
    events = Event.where('date > ?', DateTime.now).order("date")
    @events_this_year = events.inject([]) { |arr, event| arr << event if event.date.year == DateTime.now.year }
  end

  def calendar
    @next_event = Event.where('date > ?', DateTime.now).order("date").first
    events = Event.where('date > ?', DateTime.now).order("date")
    @events_this_year = events.inject([]) { |arr, event| arr << event if event.date.year == DateTime.now.year }

    @past_events = Event.past_events
  end

  def sponsor
    @next_event = Event.where('date > ?', DateTime.now).order("date").first
    events = Event.where('date > ?', DateTime.now).order("date")
    @events_this_year = events.inject([]) { |arr, event| arr << event if event.date.year == DateTime.now.year }
  end

  def request_to_speak
    @next_event = Event.where('date > ?', DateTime.now).order("date").first
    events = Event.where('date > ?', DateTime.now).order("date")
    @events_this_year = events.inject([]) { |arr, event| arr << event if event.date.year == DateTime.now.year }
  end

end
