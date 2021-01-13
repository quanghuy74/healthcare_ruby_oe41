source "https://rubygems.org"
git_source(:github){|repo| "https://github.com/#{repo}.git"}

ruby "2.7.0"

gem "bootsnap", ">= 1.4.4", require: false
gem "puma", "~> 5.0"
gem "rails", "~> 6.1.3"
gem "sqlite3", "~> 1.4"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "rspec-rails", "~> 4.0.1"
  gem "rubocop", "~> 0.74.0", require: false
  gem "rubocop-checkstyle_formatter", require: false
  gem "rubocop-rails", "~> 2.3.2", require: false
end

group :development do
  gem "listen", "~> 3.3"
  gem "spring"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
