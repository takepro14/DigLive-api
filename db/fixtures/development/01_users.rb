(1..10).each do |n|
  User.seed do |s|
    s.name = Faker::Name.name
    s.email = "test-user#{n}@example.com"
    s.password = "password"
    s.profile = Faker::Lorem.paragraph
    s.avatar = Rails.root.join("public/uploads/user/avatar/#{n}/User#{n}.jpg").open
    s.activated = true
  end
end

# 大量データ用
(11..100).each do |n|
  User.seed do |s|
    s.name = Faker::Name.name
    s.email = "test-user#{n}@example.com"
    s.password = "password"
    s.profile = Faker::Lorem.paragraph
    s.activated = true
  end
end