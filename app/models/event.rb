class Event < ActiveRecord::Base
  has_many :speaking_engagements
  has_many :sponsorships
  has_many :speakers, through: :speaking_engagements
  has_many :sponsors, through: :sponsorships
  belongs_to :venue

  def self.past_events
    Event.where('date < ?', DateTime.now).order("date DESC").inject(Hash.new) { |hash, event|
      if hash[event.date.year.to_s]
        hash[event.date.year.to_s] << event
        hash[event.date.year.to_s].sort_by! { |event| event.date }.reverse!
        hash
      else
        hash[event.date.year.to_s] = [event]
        hash
      end
    }
  end

  def self.events_by_year(all = true)
    e = nil
    all ? e = Event.all : e = Event.where(live: true)
    e.order("date DESC").inject(Hash.new) { |hash, event|
      if hash[event.date.year.to_s]
        hash[event.date.year.to_s] << event
        hash[event.date.year.to_s].sort_by! { |event| event.date }.reverse!
        hash
      else
        hash[event.date.year.to_s] = [event]
        hash
      end
    }
  end

  def agenda
    YAML.load(super) if super
  end

  def to_s
    self.name
  end

end
