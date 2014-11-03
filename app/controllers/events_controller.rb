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
    agenda = Hash[params[:agenda].sort].inject([]) { |c, (k,v)|
      v[:speaker] = Speaker.find_by_id v[:speaker].to_i
      c << v
    }
    Hash[params[:sponsors].sort].each do |k,v|
      v[:sponsor_ids].each do |id|
        s = Sponsorship.new event_id: this_event.id,
                            sponsor_id: id,
                            level: v[:level]
        if !s.save
          sponsorship = Sponsorship.where(event_id: this_event.id, sponsor_id: id).first
          Sponsorship.update sponsorship.id, { event_id: this_event.id,
                                               sponsor_id: id,
                                               level: v[:level] }
        end
      end
    end
    venue = Venue.find_by_id event[:venue]
  end

end
