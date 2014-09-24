# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

5.times do
  Event.create(name: Faker::Company.name,
               date: DateTime.now)
end

10.times do
  new_speaker = Speaker.create(first_name: Faker::Name.first_name,
                               last_name: Faker::Name.last_name,
                               job_title: Faker::Name.title,
                               employer: Faker::Company.name)
  Event.all.sample.speakers << new_speaker
end

10.times do
  new_sponsor = Sponsor.create(name: Faker::Company.name)
  Event.all.sample.sponsors << new_sponsor
end

5.times do
  Venue.create(name: Faker::Company.name,
               street: Faker::Address.street_address,
               city: Faker::Address.city,
               state: Faker::Address.state_abbr,
               zip: Faker::Address.zip)
end

Event.all.each_with_index do |event, index|
  venue = Venue.find_by_id(event.id)
  event.venue = venue
  event.save!
end
