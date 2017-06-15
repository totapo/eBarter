class PropostasController < ApplicationController
  def new
    @id_item = params[:id_item]
    @itens = Item.where(dono_id: session[:id_usuario])
  end

  def adicionar_item
    id_item = params[:id_item]
    session[:itens_ofertados].push id_item
    inicia_tela
  end

  def remover_item
    id_item = params[:id_item]
    session[:itens_ofertados].delete id_item
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
