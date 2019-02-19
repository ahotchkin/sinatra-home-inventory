class ItemsController < ApplicationController

  get '/items' do
    if logged_in?
      @items = current_user.items.sort { |a, b| a.name <=> b.name }
      erb :'/items/index'
    else
      redirect "/login"
    end
  end

  get '/items/new' do
    if logged_in?
      @groups = current_user.groups.uniq.sort { |a, b| a.name <=> b.name }
      erb :'/items/new'
    else
      redirect "/login"
    end
  end

  post '/items' do
    if logged_in? && !params[:item_name].empty? && !params[:cost].empty?
      groups = current_user.groups
      item = Item.new(name: params[:item_name], cost: params[:cost], date_purchased: params[:date_purchased])
      item.user_id = current_user.id
      if !groups.empty?
        item.group_ids = params[:item][:group_ids]
      end
      if !params[:group_name].empty?
        item.groups << Group.create(name: params[:group_name])
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
      @groups = current_user.groups.uniq.sort { |a, b| a.name <=> b.name }
      erb :'/items/edit'
    else
      redirect "/login"
    end
  end

  patch '/items/:slug' do
    item = Item.find_by_slug(params[:slug])
    if !params[:item_name].empty? && !params[:cost].empty?
      item.update(name: params[:item_name], cost: params[:cost], date_purchased: params[:date_purchased])
      item.group_ids = params[:item][:group_ids]
      if !params[:group_name].empty?
        item.groups << Group.create(name: params[:group_name])
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
