class EventsController < ApplicationController

  def index
    if_logged_in { @events_by_year = Event.events_by_year }
  end

  def show
    if_logged_in { @event = Event.find_by_id params[:id] }
  end

  def new
    if_logged_in { @event = Event.new }
  end

  def edit
    if_logged_in { @event = Event.find_by_id params[:id] }
  end

  def update
    this_event = Event.find_by_id params[:id]
    event = params[:event]
    levels = this_event.sponsorships.group("level").count.keys
    date =  DateTime.new(event["date(1i)"].to_i,
                      event["date(2i)"].to_i,
                      event["date(3i)"].to_i,
                      event["date(4i)"].to_i,
                      event["date(5i)"].to_i,
                      0,
                      ((Time.zone.utc_offset / 60) / 60).to_s)
    speakers = lambda{
      s = event[:speaker_ids]
      s.map! { |x| x = Speaker.find_by_id(x.to_i) }
      s
    }.call
    sponsors = lambda{
      s = params[:sponsors].inject([]) { |arr,(k,v)| arr << v[:sponsor_ids] }.flatten
      s.map! { |x| x = Sponsor.find_by_id x }
    }.call
    agenda = Hash[params[:agenda].sort].inject([]) { |c, (k,v)|
      v[:speaker] = Speaker.find_by_id v[:speaker].to_i
      c << v
    }
    venue = Venue.find_by_id event[:venue]
    Event.update params[:id], { name: event[:name],
                                date: date,
                                site_url: (event[:site_url] == "" ? nil : event[:site_url]),
                                reg_url: (event[:reg_url] == "" ? nil : event[:reg_url]),
                                venue: venue,
                                agenda: agenda,
                                speakers: speakers,
                                sponsors: sponsors,
                                venue: venue,
                                live: event[:live] }
    Hash[params[:sponsors].sort].each do |k,v|
      v[:sponsor_ids].each do |id|
        sponsorship_id = Sponsorship.where(event_id: this_event.id, sponsor_id: id).first.id
        Sponsorship.update sponsorship_id, level: v[:level]
      end
    end
    flash[:message] = this_event.to_s + " updated successfully!"
    redirect_to event_path(this_event)
    return
  end

  def create
    event = params[:event]
    date =  DateTime.new(event["date(1i)"].to_i,
                         event["date(2i)"].to_i,
                         event["date(3i)"].to_i,
                         event["date(4i)"].to_i,
                         event["date(5i)"].to_i,
                         0,
                         ((Time.zone.utc_offset / 60) / 60).to_s)
    speakers = lambda{
      s = event[:speaker_ids]
      s.map! { |x| x = Speaker.find_by_id(x.to_i) }
      s
    }.call
    sponsors = lambda{
      s = params[:sponsors].inject([]) { |arr,(k,v)| arr << v[:sponsor_ids] }.flatten
      s.map! { |x| x = Sponsor.find_by_id x }
    }.call
    venue = Venue.find_by_id event[:venue]
    this_event = Event.new name: event[:name],
                           date: date,
                           site_url: (event[:site_url] == "" ? nil : event[:site_url]),
                           reg_url: (event[:reg_url] == "" ? nil : event[:reg_url]),
                           venue: venue,
                           speakers: speakers,
                           sponsors: sponsors,
                           venue: venue,
                           live: event[:live]
    if this_event.save
      Hash[params[:sponsors].sort].each do |k,v|
        v[:sponsor_ids].each do |id|
          sponsorship_id = Sponsorship.where(event_id: this_event.id, sponsor_id: id).first.id
          Sponsorship.update sponsorship_id, level: v[:level]
        end
      end
      flash[:message] = this_event.to_s + " created successfully!"
      redirect_to event_path(this_event)
      return
    else
      flash[:message] = "Something went wrong. Please try again."
      redirect_to new_event_path
      return
    end
  end

end
