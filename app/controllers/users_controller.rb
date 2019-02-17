class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/items'
    else
      erb :'users/new'
    end
  end

  post '/signup' do
    if User.find_by(username: params[:username])
      flash[:message] = "This username is taken. Please enter a new username."
      # puts flash[:message]
      redirect "/signup"
    else
      user = User.new(username: params[:username], email: params[:email], password: params[:password])
      if user.save
        session[:user_id] = user.id
        redirect "/items"
      else
        flash[:message] = "Please enter a valid username, email, and password to create an account."
        redirect "/signup"
      end
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
      flash[:message] = "Incorrect username or password entered."
      redirect "/login"
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
    end
    redirect "/login"
  end

end
