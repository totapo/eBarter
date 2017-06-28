class Publica < ApplicationRecord
  self.table_name = "publica"
  belongs_to :proposta, foreign_key:"proposta_id"
  belongs_to :leilao, foreign_key:"leilao_destino_id"
  has_one :leilao, foreign_key:"vencedora_id"
end
