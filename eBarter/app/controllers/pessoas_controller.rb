class PessoasController < ApplicationController

	def index
		@pessoa = Pessoa.find(session[:id_usuario])
	end

	def new
		@pessoa = Pessoa.new
	end

	def show
	end

	def update
		Pessoa.update(session[:id_usuario], pais: params[:pais], cidade: params[:cidade], estado: params[:estado])
		redirect_to pessoas_path
	end

	def edit
		@pessoa = Pessoa.find(session[:id_usuario])
		if(!@pessoa)
			redirect_to login_path
		end
	end

	def create
		@pessoa = Pessoa.new(pessoas_params)
			if params.require(:pessoa)[:senha] == params[:senhaConfirma][:text]
				if(!@pessoa.save)
					showError "Preencha todos os campos!"
				else
					redirect_to @pessoa
				end
			else
				showError "Senhas não conferem!"
			end
	end

	def showError(message)
		 flash[:error] = message
		render :new
	end

	private
		def pessoas_params
			params.require(:pessoa).permit(:nome, :email, :senha, :cidade, :estado, :pais)
		end

end
