class SessionsController < ApplicationController
  def new
  end

  def create
		@pessoa = Pessoa.find_by email: params[:email], senha: params[:senha]
		if @pessoa
			session[:id_usuario] = @pessoa.id
      redirect_to home_path
    else
      showError("Usuário e senha inválidos")
		end
	end

	def showError(message)
		 flash[:error] = message
		render :new
	end
end
