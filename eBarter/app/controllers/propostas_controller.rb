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
    @itens = Item.where(dono_id: session[:id_usuario])
    @itens_ofertados = []
    @itens_ofertados.push(Item.find(params[:id_item]))
    redirect_to new_proposta_path()
  end

  def create

  end
end
