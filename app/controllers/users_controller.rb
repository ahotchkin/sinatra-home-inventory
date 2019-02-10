class UsersController < ApplicationController

  get '/signup' do
    # commented out logged_in? if statement because ActiveRecord kept trying to find User with id=4, which didn't exist
    if logged_in?
      redirect '/items'
    else
      erb :'users/new'
    end
    # erb :'/users/new'
  end

  post '/signup' do
    # add functionality to prevent a user from creating a username that already exists
    user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if user.save
      session[:user_id] = user.id
      redirect "/items"
    else
      redirect "/signup"
    end
  end

  get '/login' do
    if logged_in?
      redirect "/items"
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/items"
    else
      redirect "/login"
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
    else
      redirect "/login"
    end
  end

end
