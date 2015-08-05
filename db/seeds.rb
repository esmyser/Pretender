# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

5.times do |i|
	User.create(name: "John #{i}")
end

10.times do |i|
	Pretendee.create(twitter: "@bgadbaw", name: "Pretendee #{i}", user_id: i/2)
end

20.times do |i|
	Topic.create(name: "topic #{i}", pretendee_id: i/2)
end