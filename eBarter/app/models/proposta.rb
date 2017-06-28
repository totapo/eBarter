class Proposta < ApplicationRecord
  self.table_name = "proposta"
	belongs_to :pessoa, foreign_key:"pessoa_id"
  has_many :envolve
  has_many :item, through: :envolve
  has_one :troca, foreign_key:"id"
  has_one :pessoal, foreign_key:"proposta_id"
  has_one :publica, foreign_key:"proposta_id"
end
