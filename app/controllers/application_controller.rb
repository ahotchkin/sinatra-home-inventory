class ApplicationController < Sinatra::Base

  configure do
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_security"
    use Rack::Flash
  end

  get '/' do
    erb :'index'
  end

  helpers do

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    def redirect_unless_logged_in
      if !logged_in?
        redirect "/login"
      end
    end

    def current_item
      Item.find_by_slug(params[:slug])
    end

    def current_users_groups
      current_user.groups.uniq.sort { |a, b| a.name <=> b.name }
    end

  end

end
