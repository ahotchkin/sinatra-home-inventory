class CategoriesController < ApplicationController

  get '/categories' do
    @categories = current_user.categories.sort { |a, b| a.name <=> b.name }
    erb :'/categories/index'
  end

end
