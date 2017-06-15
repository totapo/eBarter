class PropostasController < ApplicationController
  def new
    if request.post?
      val = params[:lista]
      metodo = params[:op]
      lista=[]
      if(val=="0") #lista usuario logado
        lista = session[:itens_ofertados]
      else
        lista = session[:itens_requeridos]
      end

      if(metodo=="adicionar") #
        adicionar_item
      elsif (metodo=="remover")

      @id_item = params[:id_item]
      item = Item.find(@id_item)
      dId = item.pessoa.id
    else

    end

    @itens = Item.where(dono_id: session[:id_usuario])
  end

  def adicionar_item
    id_item = params[:id_item]
    session[:itens_ofertados].push id_item
    inicia_tela
  end

  def remover_item
    id_item = params[:id_item]
    session[:itens_ofertados] = session[:itens_ofertados] - ["#{id_item}"]
    inicia_tela
  end

  def create

  end

  private
    def inicia_tela
      @itens = Item.where(dono_id: session[:id_usuario])
      if !session[:itens_ofertados]
        session[:itens_ofertados] = []
      end
      @itens_ofertados = []
      session[:itens_ofertados].each do |i|
        @itens_ofertados.push Item.find(i)
      end
      render "new"
    end
end
