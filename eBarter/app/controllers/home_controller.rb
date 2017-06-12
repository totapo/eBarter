class HomeController < ApplicationController
  def index
    if(!session[:id_usuario])
      redirect_to login_path
    end
  end

  def pesquisar
    @pesquisa = params[:info_pesquisa].split(" ")
    sql_string = ""
    first = true
    @pesquisa.each do |param|
      if first
        sql_string += "NOME LIKE '%#{param}%' "
        first = false
      else
        sql_string += "AND NOME LIKE '%#{param}%' "
      end
    end
    @itens = Item.where(sql_string)
    render "index"
  end
end
