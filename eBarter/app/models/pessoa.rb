class Pessoa < ApplicationRecord
	self.table_name = "pessoa"
	self.primary_key = 'id'
	has_many :propostas, foreign_key:"pessoa_id"
	has_many :pessoal, foreign_key: "destinatario_id"
	has_many :item, foreign_key:"dono_id"
	has_many :avaliacao, foreign_key:"destinatario_id"
	has_and_belongs_to_many :tag
	has_and_belongs_to_many :categoria
	validates :nome, :email, :senha, presence: true
end
