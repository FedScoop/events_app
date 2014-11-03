class Event < ActiveRecord::Base
  has_many :speaking_engagements
  has_many :sponsorships
  has_many :speakers, through: :speaking_engagements
  has_many :sponsors, through: :sponsorships
  belongs_to :venue
  before_save { |event|
    speaker_objects_to_ids
    event.agenda = event.agenda.to_yaml if event.agenda
  }

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
    return_value = super
    if return_value.class == String
      agenda = YAML.load(return_value) if return_value
      return speaker_ids_to_objects agenda
    else
      return return_value
    end
  end

  def to_s
    self.name
  end

  private

  def speaker_objects_to_ids
    if self.agenda.class == Array
      self.agenda.each do |i|
        i[:speaker] = lambda{
          if i[:speaker]
            return i[:speaker].id
          else
            return nil
          end
        }.call
      end
    end
  end

  def speaker_ids_to_objects(agenda)
    agenda.each do |i|
      id = lambda {
        if i[:speaker].class == Speaker
          return i[:speaker].id
        else
          return i[:speaker].to_i
        end
      }.call
      i[:speaker] = Speaker.find_by_id(id)
    end
    agenda
  end

end
