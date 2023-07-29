source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.5'
gem 'mysql2', '0.5.3'
gem 'whenever', require: false

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  gem 'pry', '0.13.1'
  gem 'pry-byebug', '3.9.0'
  gem 'pry-rails', '0.3.9'
  gem 'rubocop-rails', '2.8.1', require: false
  gem 'rubocop-rspec', '1.44.1', require: false
end

group :development do
  gem 'annotate', '3.0.3'
  gem 'listen', '3.5.1'
  # Use Puma as the app server
  gem 'puma', '~> 3.11'
  gem 'solargraph'
  gem 'ruby-lsp'
end

group :test do
  gem 'database_cleaner', '1.8.5'
  gem 'factory_girl_rails', '4.9.0'
  gem 'rspec-collection_matchers', '1.2.0'
  gem 'rspec-its', '1.3.0'
  gem 'rspec-rails', '5.0.1'
  gem 'shoulda-matchers', '4.4.1'
  gem 'simplecov', '0.18.5', require: false
end
