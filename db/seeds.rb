#Create 50 fake users
50.times do
  User.create!(email: Faker::Internet.email, password: Faker::Internet.password)
end

users = User.all

#Create 100 fake wikis
100.times do
  Wiki.create!(title: Faker::Hipster.word, body: Faker::Hipster.paragraph(7), user: users.sample)
end

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
