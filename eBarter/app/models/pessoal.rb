class Pessoal < ApplicationRecord
  self.table_name = "pessoal"
  has_one: proposta, foreign_key:"proposta_id"
  has_one: pessoa, foreign_key:"destinatario_id"
end
