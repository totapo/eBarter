class AvaliacoesController < ApplicationController
  def avaliar
    if(!session[:id_usuario])
      redirect_to login
    end
    @troca = Troca.find(params[:id])

    if(@troca)
      @user1 = @troca.proposta.pessoa
      if(@troca.proposta.publica)
        @user2 = @troca.proposta.publica.leilao.pessoa
      else
        @user2 = @troca.proposta.pessoal.pessoa
      end

      @destinatario=nil
      @aval=nil

      if(@user1.id == session[:id_usuario])
        @destinatario = @user2
      elsif(@user2.id == session[:id_usuario])
        @destinatario = @user1
      end

      if(@destinatario)
        @troca.avaliacao.each do |av|
          if(av.destinatario_id==@destinatario.id)
            @aval = av
            break
          end
        end

        render "show"
      end
    end
  end

  def cadastrar
    if(!session[:id_usuario])
      redirect_to login
    end
    @troca = Troca.find(params[:id_troca])
    @destinatario = Pessoa.find(params[:id_destinatario])
    @aval = nil

    if(@troca && @destinatario)
      @troca.avaliacao.each do |av|
        if(av.destinatario_id==@destinatario.id)
          @aval = av
          break
        end
      end

      if(!@aval)
        @aval = Avaliacao.new(
          :troca_id=>@troca.id, :destinatario_id=>@destinatario.id,
          :nota => params[:nota], :descricao=>params[:descricao]
          )
      else
        @aval.nota = params[:nota]
        @aval.descricao=params[:descricao]
      end


      if(!@aval.save)
        showMessage("Preencha todos os campos adequadamente! (separador decimal '.')", @troca)
      else
        showMessage("Avaliação salva com sucesso!", @troca)
      end
    end
  end

  def showMessage(message, troca)
		 flash[:message] = message
		 redirect_to avaliar_troca_path(id: troca.id)
	end
end
