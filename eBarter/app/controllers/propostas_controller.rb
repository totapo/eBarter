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

      if(metodo=="adicionar")
        adicionar_item
      elsif (metodo=="remover")
        remover_item
      end
    else
      id_item = params[:id_item]
      @item = Item.find(id_item)
      session[:id_dono] = @item.pessoa.id
      if !session[:itens_demandados]
        session[:itens_demandados] = []
      end
      session[:itens_demandados].push id_item
      if !session[:quantidade_demandados]
        session[:quantidade_demandados] = Hash.new
      end
      session[:quantidade_demandados]["#{id_item}"] = 1
    end

    #@id_item = params[:id_item]
    #item = Item.find(@id_item)
    #dId = item.pessoa.id

   inicia_tela
  end

  def show
  end

  def adicionar_item
    id_item = params[:id_item]
    if !session[:quantidade_ofertados]
      session[:quantidade_ofertados] = Hash.new
    end
    if !session[:itens_ofertados]
      session[:itens_ofertados] = []
    end
    session[:itens_ofertados].push id_item
    session[:quantidade_ofertados]["#{id_item}"] = 1
    inicia_tela
  end

  def adicionar_item_demandado
    id_item = params[:id_item]
    if !session[:quantidade_demandados]
      session[:quantidade_demandados] = Hash.new
    end
    if !session[:itens_demandados]
      session[:itens_demandados] = []
    end
    session[:itens_demandados].push id_item
    session[:quantidade_demandados]["#{id_item}"] = 1
    inicia_tela
  end

  def remover_item
    id_item = params[:id_item]
    session[:itens_ofertados] = session[:itens_ofertados] - ["#{id_item}"]
    inicia_tela
  end

  def remover_item_demandado
    id_item = params[:id_item]
    session[:itens_demandados] = session[:itens_demandados] - ["#{id_item}"]
    inicia_tela
  end

  def create
      @proposta = Proposta.create(estado: 1, data_abertura: Time.now, pessoa_id: session[:id_usuario], texto: params['texto'])
      itens_ofertados = []
      session[:itens_ofertados].each do |i|
        quant = session[:quantidade_ofertados]["#{i}"]
        @proposta.envolve.create(item_id:i, quantidade:quant)
      end
      session[:itens_demandados].each do |i|
        quant = session[:quantidade_demandados]["#{i}"]
        @proposta.envolve.create(item_id:i, quantidade:quant)
      end
      redirect_to proposta_path id: @proposta.id
  end

  def alterar_quantidade_ofertado
    id_item = params['id_item']
    quant = params['quantidade']
    session[:quantidade_ofertados]["#{id_item}"] = quant
    inicia_tela
  end

  def alterar_quantidade_demandado
    id_item = params['id_item']
    quant = params['quantidade']
    session[:quantidade_demandados]["#{id_item}"] = quant
    inicia_tela
  end

  private
    def inicia_tela
      @itens_dono = Item.where(dono_id: session[:id_dono])
      @itens = Item.where(dono_id: session[:id_usuario])
      if !session[:itens_ofertados]
        session[:itens_ofertados] = []
      end
      if !session[:quantidade_demandados]
        session[:quantidade_demandados] = Hash.new
      end
      @itens_ofertados = []
      session[:itens_ofertados].each do |i|
        @itens_ofertados.push Item.find(i)
      end
      @itens_demandados = []
      session[:itens_demandados].each do |i|
        @itens_demandados.push Item.find(i)
      end
      render "new"
    end
end
