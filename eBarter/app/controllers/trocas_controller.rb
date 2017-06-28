class TrocasController < ApplicationController
  def show
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
