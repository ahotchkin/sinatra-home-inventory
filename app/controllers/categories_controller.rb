class CategoriesController < ApplicationController

  get '/categories' do
    @categories = Category.all.sort { |a, b| a.name <=> b.name }
    erb :'/categories/index'
  end

end
