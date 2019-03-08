class GroupsController < ApplicationController

  get '/groups' do
    redirect_unless_logged_in
    @groups = current_user.groups.uniq.sort { |a, b| a.name <=> b.name }
    erb :'/groups/index'
  end

  get '/groups/:slug' do
    redirect_unless_logged_in
    @group = Group.find_by_slug(params[:slug])
    @items = @group.items.sort { |a, b| a.name <=> b.name }
    erb :'/groups/show'
  end

end
