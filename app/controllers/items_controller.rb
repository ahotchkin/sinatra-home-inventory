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
      flash[:message] = "Item successfully added."
      redirect "/items"
    elsif logged_in? && params[:item][:name] == ""
      flash[:message] = "Please enter the item's name and cost."
      redirect "/items/new"
    elsif logged_in? && params[:item][:cost] == ""
      flash[:message] = "Please enter the item's name and cost."
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
    if params[:item][:name] != "" && params[:item][:cost] != ""
      @item.update(params[:item])
      flash[:message] = "Item successfully updated."
      redirect "/items/#{@item.slug}"
    elsif params[:item][:name] == "" || params[:item][:cost] == ""
      flash[:message] = "Please enter a name and cost for the item."
      redirect "/items/#{@item.slug}/edit"
    end
  end

  delete '/items/:slug/delete' do
    @item = Item.find_by_slug(params[:slug])
    if logged_in? && @item.user_id == current_user.id
      @item.delete
      flash[:message] = "Item successfully deleted."
      redirect "/items"
    else
      redirect "/login"
    end
  end

end
