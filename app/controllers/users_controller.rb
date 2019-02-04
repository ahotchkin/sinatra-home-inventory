class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/items'
    else
      erb :'users/new'
    end
  end

  post '/signup' do
    # add functionality to prevent a user from creating a username that already exists
    user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if user.save
      session[:user_id] = user.id
      redirect '/items'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/items'
    else
      erb :'/login'
    end
  end
  
  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.password.authenticate
  end

end
