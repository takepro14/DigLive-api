10.times do |n|
	name = "user#{n}"
	email = "#{name}@example.com"
	# メールアドレスの一意性検証を回避
	user = User.find_or_initialize_by(email: email, activated: true)

	# userが新しいレコードならばtrue
	if user.new_record?
		user.name = name
		user.password = "password"
		user.save!
	end
end

puts "users = #{User.count}"