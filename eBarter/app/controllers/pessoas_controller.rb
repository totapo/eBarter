class PessoasController < ApplicationController
	def new
		@pessoa = Pessoa.new
	end

	def show
	end

	def login

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

	def submitlogin
		@pessoa = Pessoa.find_by email: login_params[:email], senha: login_params[:senha]
		if @pessoa
			session[:user_id] = @pessoa.id;
		end
	end

	def showError(message)
		 flash[:error] = message
		render :new
	end

	private
		def login_params
			params.require(:pessoa).permit(:email, :senha)
		end

	private
		def pessoas_params
			params.require(:pessoa).permit(:nome, :email, :senha, :cidade, :estado, :pais)
		end

end
