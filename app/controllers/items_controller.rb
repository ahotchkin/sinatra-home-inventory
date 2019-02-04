class ItemsController < ApplicationController

  get '/items' do
    @items = Item.all
    erb :'/items/index'
  end
end
