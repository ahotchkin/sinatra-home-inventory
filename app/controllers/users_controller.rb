class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/items'
    else
      erb :'users/new'
    end
  end

  post '/signup' do
    user = User.new(params[user])
  end

end
