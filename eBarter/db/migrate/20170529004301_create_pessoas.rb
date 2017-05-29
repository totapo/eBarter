class CreatePessoas < ActiveRecord::Migration[5.0]
  def change
    create_table :pessoas do |t|

      t.timestamps
    end
  end
end
