class Tag < ApplicationRecord
	self.table_name = "tag"
	has_and_belongs_to_many:pessoa
	has_and_belongs_to_many:item
end
