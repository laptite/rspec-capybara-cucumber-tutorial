source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'rails', '~> 6.0.2'
gem 'sqlite3', '~> 1.4'
gem 'puma', '~> 4.3'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 4.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'haml', '~> 5.1'
gem 'bootstrap-sass', '~> 3.4'
gem 'simple_form', '~> 5.0'
gem 'redcarpet', '~> 3.3'
gem 'devise', '~> 4.7'

gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 4.0'
  gem 'factory_bot_rails', '~> 5.1'
  gem 'spring-commands-rspec', '~> 1.0'
  gem 'spring-commands-cucumber', '~> 1.0'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
	gem 'capybara', '~> 3.32'
  gem 'cucumber-rails', '~> 2.0', require: false
  gem 'database_cleaner', '~> 1.8'
  gem 'rails-controller-testing', '~> 1.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
