class ItemsController < ApplicationController

  get '/items' do
    @items = current_user.items.sort { |a, b| a.name <=> b.name }
    erb :'/items/index'
  end

  get '/items/new' do
    if logged_in?
      erb :'/items/new'
    else
      redirect "/login"
    end
  end

  post '/items' do
    if logged_in? && params[:item][:name] != "" && params[:item][:cost] != ""
      item = Item.create(params[:item])
      item.user_id = current_user.id
      item.save
      redirect "/items"
    elsif logged_in? && params[:item][:name] == ""
      # flash message to add a name
      redirect "/items/new"
    elsif logged_in? && params[:item][:cost] == ""
      # flash message to add a cost
      redirect "/items/new"
    else
      redirect "/login"
    end
  end

  get '/items/:slug' do
    if logged_in?
      @item = Item.find_by_slug(params[:slug])
      erb :'/items/show'
    else
      redirect "/login"
    end
  end

  get '/items/:slug/edit' do
    if logged_in?
      @item = Item.find_by_slug(params[:slug])
      erb :'/items/edit'
    else
      redirect "/login"
    end
  end

  patch '/items/:slug' do
    @item = Item.find_by_slug(params[:slug])
    # if params isn't empty...
      @item.update(params[:item])
      redirect "/items/#{@item.slug}"
    # else
    #   redirect '/login'
    # end
  end

  delete '/items/:slug/delete' do
    @item = Item.find_by_slug(params[:slug])
    if logged_in? && @item.user == current_user
      @item.delete
      redirect "/items"
    else
      redirect "/login"
    end
  end

end
