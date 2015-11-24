# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


john = User.create!(email: 'john.doe@example.com')

programming = Category.create!(name: 'Programming')
marketing   = Category.create!(name: 'Marketing')
writing     = Category.create!(name: 'Writing')

Link.create!(url: 'http://ruby-doc.org/core-2.2.3/', category: programming, user: john)
Link.create!(url: 'http://api.rubyonrails.org/', category: programming, user: john)
Link.create!(url: 'http://backlinko.com', category: marketing, user: john)
Link.create!(url: 'http://www.psychotactics.com', category: writing, user: john)

