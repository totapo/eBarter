class Categoria < ActiveRecord::Base
	self.table_name = "categoria"
	has_many:item
	has_and_belongs_to_many:pessoa
end
