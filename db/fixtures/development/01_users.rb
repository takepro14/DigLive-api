(1..10).each do |n|
  User.seed do |s|
    s.name = "user#{n}"
    s.email = "user#{n}@example.com"
    s.password = "password"
  end
end