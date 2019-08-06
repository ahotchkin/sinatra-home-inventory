class ItemsController < ApplicationController

  get '/items' do
    redirect_unless_logged_in
    @items = current_user.items.sort { |a, b| a.name <=> b.name }
    erb :'/items/index'
  end

  get '/items/new' do
    redirect_unless_logged_in
    @groups = current_users_groups
    erb :'/items/new'
  end

  post '/items' do
    redirect_unless_logged_in
    if !params[:item_name].empty? && !params[:cost].empty?
      item = Item.new(name: params[:item_name], cost: params[:cost], date_purchased: params[:date_purchased])
      item.user_id = current_user.id

      ### Code below is required to allow a user to create an item without selecting an existing category
      groups = current_user.groups
      if !groups.empty?
        item.group_ids = params[:item][:group_ids]
      end

      if !params[:group_name].empty?
        item.groups << Group.create(name: params[:group_name])
      end

      item.save
      flash[:message] = "Item successfully added."
      redirect "/items"
    elsif params[:item_name].empty? || logged_in? && params[:cost].empty?
      flash[:message] = "Please enter a name and cost for the item."
      redirect "/items/new"
    end
  end

  get '/items/:slug' do
    redirect_unless_logged_in
    @item = current_item
    if @item.user == current_user
      erb :'/items/show'
    else
      redirect "/items"
    end
  end

  get '/items/:slug/edit' do
    redirect_unless_logged_in
    @item = current_item
    @groups = current_users_groups
    if @item.user == current_user
      erb :'/items/edit'
    else
      redirect "/items"
    end
  end

  patch '/items/:slug' do
    item = current_item
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

  delete '/items/:slug' do
    redirect_unless_logged_in
    @item = current_item
    if @item.user_id == current_user.id
      @item.delete
      flash[:message] = "Item successfully deleted."
      redirect "/items"
    end
  end

end
