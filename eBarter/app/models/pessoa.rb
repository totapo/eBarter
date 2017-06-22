class Pessoa < ApplicationRecord
	self.table_name = "pessoa"
	self.primary_key = 'id'
	has_many:pessoal
	has_many:item
	has_and_belongs_to_many:tag
	has_and_belongs_to_many:categoria
	
	validates :nome, :email, :senha, presence: true

end
