class Leilao < ApplicationRecord
  self.table_name = "leilao"
  has_many:publica, foreign_key:"leilao_destino_id"
  belongs_to:pessoa, foreign_key:"pessoa_id"
  
end
