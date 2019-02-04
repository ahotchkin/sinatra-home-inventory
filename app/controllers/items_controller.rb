class ItemsController < ApplicationController

  get '/items' do
    @items = Item.all
    erb :'/items/index'
  end

  get '/items/new' do
    if logged_in?
      erb :'/items/new'
    else
      redirect '/login'
    end
  end

  post '/items' do
    if logged_in? && params[:item][:name] != "" && params[:item][:cost] != ""
      item = Item.create(params[:item])
      redirect '/items'
    elsif logged_in? && params[:item][:name] == ""
      # flash message to add a name
      redirect '/items/new'
    elsif logged_in? && params[:item][:cost] == ""
      # flash message to add a cost
      redirect '/items/new'
    else
      redirect '/login'
    end
  end

  get '/items/:slug' do
    if logged_in?
      @item = Item.find_by_slug(params[:slug])
      erb :'/items/show'
    else
      redirect '/login'
    end
  end

end
