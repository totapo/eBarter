class Pessoal < ApplicationRecord
  self.table_name = "pessoal"
  belongs_to:proposta, foreign_key:"proposta_id"
  belongs_to:pessoa, foreign_key:"destinatario_id"
end
