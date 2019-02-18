class GroupsController < ApplicationController

  get '/groups' do
    @groups = Group.all.sort { |a, b| a.name <=> b.name }
    erb :'/groups/index'
  end

  get '/groups/:slug' do
    if logged_in?
      @group = Group.find_by_slug(params[:slug])
      erb :'/groups/show'
    else
      redirect "/login"
    end
  end

end