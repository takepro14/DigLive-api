# seedデータ(.rb)をどんどん追加していける
table_names = %w(
	users
)

# production, test以下に.rbがなければdevelopment以下の.rbを読み込む
table_names.each do |table_name|
	path = Rails.root.join("db/seeds/#{Rails.env}/#{table_name}.rb")

	# ファイルが存在しない場合はdevelopmentディレクトリを読み込む
	# ex) /app/db/seeds/production/users.rb が存在しない場合 /app/db/seeds/development/users.rb がpathになる
	path = path.sub(Rails.env, "development") unless File.exist?(path)

	puts "#{table_name}..."
	require path
end