class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/items'
    else
      erb :'users/new'
    end
  end

  post '/signup' do
    user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if user.save
      session[:user_id] = user.id
      redirect '/items'
    else
      redirect '/signup'
    end
  end

end
