class Troca < ActiveRecord::Base
	self.table_name = "troca"
	has_many:avaliacao
	belongs_to:proposta, foreign_key:"id"
  def getEstado()
    if(self.estado=="0")
      str="Terminada"
    elsif self.estado=="1"
      str="Cancelada"
    else
      str="Aguardando Confirmação"
    end
    return str
  end
end
