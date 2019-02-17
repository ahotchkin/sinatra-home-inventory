class CategoriesController < ApplicationController

  get '/categories' do
    @categories = Category.all.sort { |a, b| a.name <=> b.name }
    erb :'/categories/index'
  end

  get '/categories/:id' do
    if logged_in?
      @category = Category.find(params[:id])
      erb :'/categories/show'
    else
      redirect "/login"
    end
  end

end
