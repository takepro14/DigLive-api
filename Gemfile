source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.6'

gem 'rails', '~> 6.0.5', '>= 6.0.5.1'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'rack-cors'
gem 'hirb', '~> 0.7.3'
gem 'hirb-unicode-steakknife', '~> 0.0.9'
gem 'bcrypt', '~> 3.1', '>= 3.1.18'
gem 'seed-fu'
gem 'faker'
gem 'jwt', '~> 2.4', '>= 2.4.1'
gem 'pry-rails', '~> 0.3.9'
gem "awesome_print"
gem 'rename'
gem 'carrierwave', '~> 2.2', '>= 2.2.2'
gem 'mini_magick', '~> 4.11'
gem 'rails_same_site_cookie'
gem 'kaminari'
gem 'fog-aws'  # 画像をS3にアップロード

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 5.0.0'
  gem 'factory_bot_rails'
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
