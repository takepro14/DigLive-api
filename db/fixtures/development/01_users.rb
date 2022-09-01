(1..30).each do |n|
  User.seed do |s|
    s.name = Faker::Name.name
    s.email = "test-user#{n}@example.com"
    s.password = "password"
    s.activated = true
  end
end