class Avaliacao < ActiveRecord::Base
	self.table_name = "avaliacao"
	belongs_to :troca,  foreign_key: "troca_id", dependent: :destroy
	belongs_to :pessoa, foreign_key:"destinatario_id"
	validates :descricao, :nota, presence: true
	validates_numericality_of :nota, :greater_than_or_equal_to  => 0, :less_than_or_equal_to => 10
end
