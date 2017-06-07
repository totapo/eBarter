class ItemsController < ApplicationController
	def new
		@categorias = Categoria.all
	end

	def index
		@itens = Item.where(dono_id: session[:id_usuario])
	end

	def edit
		@item = Item.find(params[:id]);
	end

	def update
		@item = Item.find(params[:id])
		begin
			Item.update(@item.id, nome: params[:nome], descricao: params[:descricao], quantidade: params[:quantidade])
			redirect_to items_path
		rescue
			showError "Entre com dados válidos!"
			render :edit
		end
	end

	def show
		@item = Item.find(params[:id])
	end

	def showError(message)
		 flash[:error] = message
	end

	def create
		#render plain: params[:item].inspect
		@item = Item.new(items_params)
		@item .save
		redirect_to items_path
	end

	private
		def items_params
			params.require(:item).permit(:nome, :descricao, :quantidade, :categoria_id).merge(dono_id:session[:id_usuario])
		end
end
