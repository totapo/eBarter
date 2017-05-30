class PessoasController < ApplicationController
	def new
		@pessoa = Pessoa.new
	end
		
	def show
	end
		
	def create
		
		@pessoa = Pessoa.new(pessoas_params)
		if params.require(:pessoa)[:email] == params[:emailConfirma][:text]
			@pessoa.save
			redirect_to @pessoa 
		else
			flash[:error] = "Endereços de E-mail não conferem!"
			render :new
		end
	end

	private
		def pessoas_params
			params.require(:pessoa).permit(:nome, :email, :senha, :cidade, :estado, :pais)
		end
		
end
