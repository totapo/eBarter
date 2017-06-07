class HomeController < ApplicationController
  def index
    if(!session[:id_usuario])
      redirect_to login_path
    end
  end

  def pesquisar
    @pesquisa = params[:info_pesquisa].split(" ")
    @pesquisa.each do |param|
      like_keyword = "%#{param}%"
      @items = Item.where("NOME LIKE ?", like_keyword)
    end
  end
end
