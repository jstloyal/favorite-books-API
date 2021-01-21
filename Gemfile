source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.4'
gem 'figaro'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'

gem 'rubocop', '~>0.81.0'

# Use Active Storage variant
gem 'aws-sdk-s3', require: false
gem 'bootsnap', '>= 1.4.2', require: false
gem 'image_processing', '~> 1.2'

gem 'devise_token_auth'
gem 'rack-cors'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'hirb'
  gem 'listen'
end

group :development, :test do
  %w[rspec-core rspec-rails rspec-expectations rspec-mocks rspec-support].each do |lib|
    gem lib
  end
end

group :test do
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker', git: 'https://github.com/faker-ruby/faker.git', branch: 'master'
  gem 'shoulda-matchers', '~> 4.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
