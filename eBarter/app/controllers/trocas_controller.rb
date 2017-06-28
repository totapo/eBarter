class TrocasController < ApplicationController

  def create
    @proposta = Proposta.find(params[:id_proposta])
    @proposta.estado = 2
    @proposta.data_encerramento = Time.now.to_i * 1000
    @proposta.save

    @troca = Troca.new
    @troca.id = @proposta.id
    @troca.estado = 4
    @troca.save
    redirect_to trocas_path
  end

  def index
    if(!session[:id_usuario])
      redirect_to login
    end
    @usuario = Pessoa.find(session[:id_usuario])
    @trocas=[]
    @usuario.pessoal.each do |pessoal|
        if(pessoal.proposta.troca)
          @trocas.push(pessoal.proposta.troca)
        end
    end
    @usuario.propostas.each do |pr|
      if(pr.troca)
        @trocas.push(pr.troca)
      end
    end
    render "show"
  end

  def confirmar
    if(!session[:id_usuario])
      redirect_to login
    end
    @usuario = Pessoa.find(session[:id_usuario])
    @troca = Troca.find(params[:id])
    @user1 = @troca.proposta.pessoa
    @itens=nil
    if(@troca.proposta.publica)
      @user2 = @troca.proposta.publica.leilao.pessoa
    else
      @user2 = @troca.proposta.pessoal.pessoa
      @itens = @troca.proposta.envolve
    end

    #estados
    #0 - confirmada
    #1 - Cancelada
    #2 - user 1 confimou
    #3 - user 2 confirmou
    #4 - aberta (ninguem confirmou)
    if(@troca.estado=="2")
      if(@usuario.id==@user2.id)
        @troca.estado=="0"
      end
    elsif(@troca.estado=="3")
      if(@usuario.id == @user1.id)
        @troca.estado="0"
      end
    elsif(@troca.estado=="4" && @user1.id==@usuario.id)
      @troca.estado="2"
    elsif(@troca.estado=="4" && @user2.id==@usuario.id)
      @troca.estado="3"
    end


    if(@troca.estado=="0")
      @itens.each do |env|
        @item = env.item
        @item.quantidade = @item.quantidade-env.quantidade
        if(@item.quantidade<0)
          next
        end
        @item.save
      end
      @troca.data_encerramento= Time.now.to_i * 1000
    end
    @troca.save
    redirect_to trocas_path
  end

  def cancelar
    if(!session[:id_usuario])
      redirect_to login
    end
    @usuario = Pessoa.find(session[:id_usuario])
    @troca = Troca.find(params[:id])
    if(@troca)
      @user1 = @troca.proposta.pessoa
      if(@troca.proposta.publica)
        @user2 = @troca.proposta.publica.leilao.pessoa
      else
        @user2 = @troca.proposta.pessoal.pessoa
      end

      if(@user1.id==@usuario.id || @user2.id==@usuario.id)
        @troca.estado="1"
        @troca.save
      end
    end
    redirect_to trocas_path
  end
end
