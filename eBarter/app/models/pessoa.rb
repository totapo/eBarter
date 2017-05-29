class Pessoa < ApplicationRecord
	self.table_name = "pessoa"
	has_many:item
	has_and_belongs_to_many:tag
	has_and_belongs_to_many:categoria
end
