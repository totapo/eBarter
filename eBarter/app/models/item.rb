class Item < ActiveRecord::Base
	self.table_name = "item"
	belongs_to:categoria
	belongs_to:pessoa, foreign_key:"dono_id"
	has_many:envolve
	has_many:proposta, through: :envolve
end
