class PropostasController < ApplicationController
  def new
    @id_item = params[:id_item]
  end
end
