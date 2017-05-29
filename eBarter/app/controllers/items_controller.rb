class ItemsController < ApplicationController
	def new
		@categorias = Categoria.all
	end
	
	def show
		@item = Item.find(params[:id])
	end
	
	def create
		#render plain: params[:item].inspect
		@item = Item.new(items_params)
		@item .save
		redirect_to @item 
	end
	
	private
		def items_params
			params.require(:item).permit(:nome, :descricao, :quantidade, :categoria_id).merge(dono_id:1)
		end
end
