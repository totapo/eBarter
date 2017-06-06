class HomeController < ApplicationController
  def index
    if(!session[:id_usuario])
      redirect_to login_path
    end
  end
end
