# coding:utf-8
require "sinatra"
require "sinatra/reloader"
require "active_record"
require "json"

ActiveRecord::Base.establish_connection(ENV["DATABASE_URL"] || "sqlite3:db/development.db")

helpers do
  include Rack::Utils
  alias_method :h, :escape_html
end

class Works < ActiveRecord::Base
end

get "/" do
  @title = "Dashboard"
  @works = Works.order("id desc").all
  erb :index
end

post "/new" do
  Works.create({
    :left_breast => params[:left_breast],
    :right_breast => params[:right_breast]
  })
  redirect "/"
end

post "/breast" do
  Works.create({
    :left_breast => params[:left_breast],
    :right_breast => params[:right_breast]
  })
  redirect "/"
end

post "/bottle" do
  Works.create({
    :baby_bottle => params[:baby_bottle]
  })
  redirect "/"
end

get "/:id/edit" do
  @works = Works.find(params[:id])
  erb :edit
end

put "/:id/edit" do
  @works = Works.find(params[:id])
  @works.update({
    :left_breast => params[:left_breast],
    :right_breast => params[:right_breast]
  })
  redirect "/"
end

get "/works.json" do
  content_type :json
  works = Works.all
  works.to_json
end

post "/delete" do
  Works.find(params[:id]).destroy
end
