class Avaliacao < ActiveRecord::Base
	self.table_name = "avaliacao"
	belongs_to :troca,  foreign_key: "troca_id"
	belongs_to :pessoa, foreign_key:"destinatario_id"
end
