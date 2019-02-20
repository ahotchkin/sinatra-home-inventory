class GroupsController < ApplicationController

  get '/groups' do
    if logged_in?
      @groups = current_user.groups.uniq.sort { |a, b| a.name <=> b.name }
      erb :'/groups/index'
    else
      redirect "/login"
    end
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
