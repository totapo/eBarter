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
  end
end
