(1..10).each do |n|
  User.seed do |s|
    s.name = Faker::Name.name
    s.email = Faker::Internet.email
    s.password = "password"
    s.activated = true
  end
end