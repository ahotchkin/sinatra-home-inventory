class ItemsController < ApplicationController

  get '/items' do
    @items = Item.all
    erb :'/items/index'
  end

  get '/new' do
    if logged_in?
      erb :'/items/new'
    else
      redirect '/login'
    end
  end

end
