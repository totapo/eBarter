class WelcomeController < ApplicationController
  def index
    if(!session[:id_usuario])
      redirect_to login_path
    else
      redirect_to home_path
    end
  end
end
