class PropostasController < ApplicationController
  def new
    #retirar
    @pessoa = Pessoa.find(session[:id_usuario])
    #retirar

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
      init_sessions
      if params[:id_proposta]
          id_proposta = params[:id_proposta]
          @proposta = Proposta.find(id_proposta)
          if @proposta.pessoa_id == session[:id_usuario]
            session[:id_dono] = Pessoal.find(@proposta.id).destinatario_id
          else
            session[:id_dono] = @proposta.pessoa_id
            session[:contra_proposta] = true
            session[:id] = @proposta.id
          end
          preenche_sessions
      else
        session[:contra_proposta] = false
        id_item = params[:id_item]
        session[:itens_demandados].push id_item
        @item = Item.find(id_item)
        session[:id_dono] = @item.pessoa.id
        session[:quantidade_demandados]["#{id_item}"] = 1
      end
    end
    inicia_tela
  end

  def show
    id_proposta = params[:id]
    @proposta = Proposta.find(id_proposta)
    @itens_ofertados = @proposta.item.where(dono_id: session[:id_usuario])
    @itens_demandados = @proposta.item.where.not(dono_id: session[:id_usuario])
    if @proposta.estado == 0
      @cancelada = true
    elsif @proposta.pessoa_id != session[:id_usuario] && @proposta.estado == 3
      @contraproposta = true
    elsif @proposta.estado == 1
      @confirmar = true
    elsif @proposta.estado == 2
      @confirmada = true
    end
  end

  def index
    @proposta_pessoal = Pessoal.joins("
      INNER JOIN
        proposta ON proposta.id = pessoal.proposta_id
      WHERE
        destinatario_id = #{session[:id_usuario]} OR pessoa_id = #{session[:id_usuario]}")
  end

  def adicionar_item
    id_item = params[:id_item]
    if !session[:quantidade_ofertados]
      session[:quantidade_ofertados] = Hash.new
    end
    if !session[:itens_ofertados]
      session[:itens_ofertados] = []
    end
    bool = false
    session[:itens_ofertados].each do |item|
      if item == id_item
        bool=true
        break
      end
    end
    if !bool
      session[:itens_ofertados].push id_item
      session[:quantidade_ofertados]["#{id_item}"] = 1
    end
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
    bool = false
    session[:itens_demandados].each do |item|
      if item == id_item
        bool=true
        break
      end
    end
    if !bool
      session[:itens_demandados].push id_item
      session[:quantidade_demandados]["#{id_item}"] = 1
    end
    inicia_tela
  end

  def remover_item
    id_item = params[:id_item]
    session[:itens_ofertados] = session[:itens_ofertados] - ["#{id_item}"]
    session[:quantidade_ofertados].delete("#{id_item}")
    inicia_tela
  end

  def remover_item_demandado
    id_item = params[:id_item]
    session[:itens_demandados] = session[:itens_demandados] - ["#{id_item}"]
    session[:quantidade_demandados].delete("#{id_item}")
    inicia_tela
  end

  def create
    if !params[:contra_proposta]
      create_proposta
    else
      create_contra_proposta
    end
    redirect_to proposta_path id: @proposta.id
  end

  def create_proposta
    print 'Create Proposta'
    @proposta = Proposta.create(estado: 3, data_abertura: Time.now, pessoa_id: session[:id_usuario], texto: params['texto'])
    itens_ofertados = []
    session[:itens_ofertados].each do |i|
      quant = session[:quantidade_ofertados]["#{i}"]
      @proposta.envolve.create(item_id:i, quantidade:quant)
    end
    session[:itens_demandados].each do |i|
      quant = session[:quantidade_demandados]["#{i}"]
      @proposta.envolve.create(item_id:i, quantidade:quant)
    end
    @pessoal = Pessoal.create(proposta_id:@proposta.id, lances:1, destinatario_id:session[:id_dono])
  end

  def create_contra_proposta
    @proposta = Proposta.find(params[:id])
    @envolves = @proposta.envolve.all
    @envolves.each do |e|
      if session[:quantidade_ofertados]["#{e.item_id}"]
        quant = session[:quantidade_ofertados]["#{e.item_id}"]
        e.update(quantidade: quant)
        session[:itens_ofertados].delete("#{e.item_id}")
      elsif session[:quantidade_demandados]["#{e.item_id}"]
        quant = session[:quantidade_demandados]["#{e.item_id}"]
        e.update(quantidade: quant)
        session[:itens_demandados].delete("#{e.item_id}")
      else
        e.destroy
      end
    end
    session[:itens_ofertados].each do |i|
      @proposta.envolve.create(item_id:i, quantidade:session[:quantidade_ofertados]["#{i}"])
    end
    session[:itens_demandados].each do |i|
      @proposta.envolve.create(item_id:i, quantidade:session[:quantidade_demandados]["#{i}"])
    end
    @proposta.update(data_abertura: Time.now, pessoa_id: session[:id_usuario], texto: params['texto'])
    @pessoal =  Pessoal.find(@proposta.id)
    @pessoal.update(lances:1, destinatario_id:session[:id_dono])
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

  def aceitar_proposta
    @proposta = Proposta.find(params[:id_proposta])
    @proposta.estado = 1
    @proposta.save
    redirect_to propostas_path
  end

  def cancelar_proposta
    @proposta = Proposta.find(params[:id_proposta])
    @proposta.estado = 0
    @proposta.save
    redirect_to propostas_path
  end

  def confirmar_resposta
    @proposta = Proposta.find(params[:id_proposta])
    @proposta.estado = 2
    @proposta.save
    redirect_to new_troca_path
  end

  private
    def inicia_tela
      @itens_dono = Item.where(dono_id: session[:id_dono])
      @itens = Item.where(dono_id: session[:id_usuario])
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

  private
    def preenche_sessions
      @proposta.envolve.each do |e|
        if(e.item.dono_id == session[:id_usuario])
          session[:itens_ofertados].push e.item_id.to_s
          session[:quantidade_ofertados]["#{e.item_id}"] = e.quantidade
        else
          session[:itens_demandados].push e.item_id.to_s
          session[:quantidade_demandados]["#{e.item_id}"] = e.quantidade
        end
      end
    end

    def init_sessions
      session[:itens_demandados] = []
      session[:quantidade_demandados] = Hash.new
      session[:itens_ofertados] = []
      session[:quantidade_ofertados] = Hash.new
    end
end
