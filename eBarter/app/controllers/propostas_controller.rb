class PropostasController < ApplicationController
  def new
    @id_item = params[:id_item]
    @itens = Item.where(dono_id: session[:id_usuario])
  end

  def adicionar_item
    @itens = Item.where(dono_id: session[:id_usuario])
    if !@itens_ofertados
      @itens_ofertados = []
    end
    @itens_ofertados.push(Item.find(params[:id_item]))
    render "new"
  end

  def create

  end
end
