# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Testimonial.create(message: 'Habanero seltzer has changed my life! I used to wet the bed, but now it burns so much on the way out that it wakes me up!', author: 'Billy')
Testimonial.create(message: 'This is a horrible product and a horrible idea. Why would anyone spend money on this?', author: 'Steve')
Testimonial.create(message: 'Is this a joke or is this a real product?', author: 'Henry')

Product.create(code: 'HABSELTZ', description: 'Habanero Seltzer Water', price: 3.95)