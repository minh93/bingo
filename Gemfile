source "https://rubygems.org"

gem "rails", "4.1.8"
gem "sass-rails", "~> 4.0.3"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.0.0"
gem "therubyracer",  platforms: :ruby
# QR code image
gem "rqrcode_png"
gem "twitter-bootstrap-rails"
gem "less-rails"
gem "jquery-rails"
gem "turbolinks"
gem "jbuilder", "~> 2.0"
gem "sdoc", "~> 0.4.0", group: :doc
gem "unicorn"

# unit test
group :development, :test do
    gem "rspec-rails", "~> 3.0"
    gem "spring"
end
group :development do
  gem "sqlite3"
  gem "byebug"
end
group :production do
  gem "rails_12factor"
  gem "mysql2"
end
