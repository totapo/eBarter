class Item < ActiveRecord::Base
	self.table_name = "item"
	belongs_to:categoria
	belongs_to:pessoa, foreign_key:"dono_id"
end
