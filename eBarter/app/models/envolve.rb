class Envolve < ApplicationRecord
  self.table_name = "envolve"
  belongs_to:proposta, foreign_key:"proposta_id"
  belongs_to:item, foreign_key:"item_id"
end
