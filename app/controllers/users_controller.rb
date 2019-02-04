class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      erb :'users/new'
    else
      redirect '/signup'
      # does this need to be '/users/signup'?
    end
  end

  post '/signup' do
    user = User.new(params[user])
  end

end
