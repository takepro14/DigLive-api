20.times do
  Board.seed do |s|
    s.title = Faker::Lorem.sentence
    s.description = Faker::Lorem.paragraph
    s.user_id = rand(1..10)
  end
end