# coding:utf-8
require "sinatra"
require "sinatra/reloader"
require "sinatra/flash"
require "active_record"
require "json"

require_relative "lib/core_ext/object"
require_relative "lib/authentication"
require_relative "lib/user"

TEN_MINUTES   = 60 * 10
use Rack::Session::Pool, expire_after: TEN_MINUTES # Expire sessions after ten minutes of inactivity
helpers Authentication

ActiveRecord::Base.establish_connection(ENV["DATABASE_URL"] || "sqlite3:db/development.db")

helpers do
  include Rack::Utils
  alias_method :h, :escape_html

  # Basic Auth
  def protected!
    unless authorized?
      response["WWW-Authenticate"] = %(Basic realm="Restricted Area")
      throw(:halt, [401, "Not authorized\n"])
    end
  end
  def authorized?
    @auth ||=  Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == ["name", "password"]
  end

  # Sinatra Auth
  def redirect_to_original_request
    user = session[:user]
    flash[:notice] = "Welcome back #{user.name}."
    original_request = session[:original_request]
    session[:original_request] = nil
    redirect original_request
  end
end

class Works < ActiveRecord::Base
end

before do
  headers "Content-Type" => "text/html; charset=utf-8"
end

get "/signin/?" do
  erb :signin,
  locals: {title: "Sign In"}
end

post "/signin/?" do
  if user = User.authenticate(params)
    session[:user] = user
    redirect_to_original_request
  else
    flash[:notice] = "サインインできませんでした。ユーザー名かパスワードが間違っています。"
    redirect "/signin"
  end
end

get "/signout" do
  session[:user] = nil
  flash[:notice] = "サインアウトしました。"
  redirect "/"
end

get "/protected/?" do
  authenticate!
  erb :protected,
  locals: {title: "Protected Page"}
end

get "/" do
  redirect "/signin/?"
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
  protected!
  "Protected page"
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
