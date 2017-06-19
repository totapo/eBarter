class Proposta < ApplicationRecord
  self.table_name = "proposta"
	belongs_to:pessoa, foreign_key:"pessoa_id"
  has_many:envolve
  has_many:item, through: :envolve
end
