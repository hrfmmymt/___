# frozen_string_literal: true
source "https://rubygems.org"

gem "sinatra"
gem "sinatra-contrib"
gem "sinatra-flash"
gem "activerecord"
gem "sinatra-activerecord", require: "sinatra/activerecord"
gem "rake"
gem "bcrypt"

group :production do
  gem "pg"
end

group :development do
  gem "sqlite3"
  gem "foreman"
end
