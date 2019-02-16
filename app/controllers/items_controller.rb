class ItemsController < ApplicationController

  get '/items' do
    @items = current_user.items.sort { |a, b| a.name <=> b.name }
    erb :'/items/index'
  end

  get '/items/new' do
    if logged_in?
      @categories =  Category.all.sort { |a, b| a.name <=> b.name }
      erb :'/items/new'
    else
      redirect "/login"
    end
  end

  post '/items' do
    if logged_in? && !params[:item_name].empty? && !params[:cost].empty?
      item = Item.new(name: params[:item_name], cost: params[:cost], date_purchased: params[:date_purchased])
      item.user_id = current_user.id
      item.category_ids = params[:item][:category_ids]
      if !params[:category_name].empty?
        item.categories << Category.create(name: params[:category_name])
      end
      item.save
      flash[:message] = "Item successfully added."
      redirect "/items"
    elsif logged_in? && params[:item_name].empty? || logged_in? && params[:cost].empty?
      flash[:message] = "Please enter a name and cost for the item."
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
      @categories =  Category.all.sort { |a, b| a.name <=> b.name }
      erb :'/items/edit'
    else
      redirect "/login"
    end
  end

  patch '/items/:slug' do
    item = Item.find_by_slug(params[:slug])
    if !params[:item_name].empty? && !params[:cost].empty?
      item.update(name: params[:item_name], cost: params[:cost], date_purchased: params[:date_purchased])
      item.category_ids = params[:item][:category_ids]
      if !params[:category_name].empty?
        item.categories << Category.create(name: params[:category_name])
      end
      item.save
      flash[:message] = "Item successfully updated."
      redirect "/items/#{item.slug}"
    elsif params[:item_name].empty? || params[:cost].empty?
      flash[:message] = "Please enter a name and cost for the item."
      redirect "/items/#{item.slug}/edit"
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
