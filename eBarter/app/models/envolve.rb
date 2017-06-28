class Envolve < ApplicationRecord
  self.table_name = "envolve"
  self.primary_keys = :item_id, :proposta_id
  belongs_to:proposta, foreign_key:"proposta_id"
  belongs_to:item, foreign_key:"item_id"
end
