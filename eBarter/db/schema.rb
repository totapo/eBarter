# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170529004301) do

  create_table "associa_se", primary_key: ["item_id", "tag_id"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "item_id", null: false
    t.bigint "tag_id",  null: false
    t.index ["tag_id"], name: "FKAss_Tag_FK", using: :btree
  end

  create_table "avaliacao", primary_key: ["troca_id", "destinatario_id"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.float  "nota",            limit: 24, null: false
    t.string "descricao",       limit: 50, null: false
    t.bigint "destinatario_id",            null: false
    t.bigint "troca_id",                   null: false
    t.index ["destinatario_id"], name: "FKPossui_FK", using: :btree
  end

  create_table "categoria", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "nome",      limit: 50, null: false
    t.string "descricao", limit: 50, null: false
  end

  create_table "deseja", primary_key: ["pessoa_id", "item_id"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "item_id",    null: false
    t.bigint "pessoa_id",  null: false
    t.bigint "quantidade", null: false
    t.index ["item_id"], name: "FKDes_Ite_FK", using: :btree
  end

  create_table "envolve", primary_key: ["proposta_id", "item_id"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint  "item_id",     null: false
    t.bigint  "proposta_id", null: false
    t.integer "quantidade",  null: false
    t.index ["item_id"], name: "FKEnv_Ite_FK", using: :btree
  end

  create_table "item", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "nome",         limit: 50,  null: false
    t.string "descricao",    limit: 50,  null: false
    t.bigint "quantidade",               null: false
    t.bigint "dono_id",                  null: false
    t.bigint "categoria_id",             null: false
    t.string "img_link",     limit: 200
    t.index ["categoria_id"], name: "FKSe_enquadra_FK", using: :btree
    t.index ["dono_id"], name: "FKTem_Item_FK", using: :btree
  end

  create_table "items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leilao", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "data_abertura",                null: false
    t.bigint "data_encerramento",            null: false
    t.bigint "pessoa_id",                    null: false
    t.bigint "vencedora_id"
    t.string "descricao",         limit: 50
    t.index ["pessoa_id"], name: "FKComeca_FK", using: :btree
    t.index ["vencedora_id"], name: "GRLeilao", using: :btree
  end

  create_table "oferta", primary_key: ["leilao_id", "item_id"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "item_id",    null: false
    t.bigint "leilao_id",  null: false
    t.bigint "quantidade", null: false
    t.index ["item_id"], name: "FKofe_Ite_FK", using: :btree
  end

  create_table "pessoa", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "nome",   limit: 50, null: false
    t.string "email",  limit: 50, null: false
    t.string "senha",  limit: 50, null: false
    t.string "cidade", limit: 50
    t.string "estado", limit: 50
    t.string "pais",   limit: 50
  end

  create_table "pessoal", primary_key: "proposta_id", id: :bigint, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "lances",          null: false
    t.bigint "destinatario_id", null: false
    t.index ["destinatario_id"], name: "FKRecebe_FK", using: :btree
  end

  create_table "pessoas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prefere_caracteristicas", primary_key: ["tag_id", "pessoa_id"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "pessoa_id", null: false
    t.bigint "tag_id",    null: false
    t.index ["pessoa_id"], name: "FKpre_Pes_FK", using: :btree
  end

  create_table "prefere_categorias", primary_key: ["categoria_id", "pessoa_id"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "categoria_id", null: false
    t.bigint "pessoa_id",    null: false
    t.index ["pessoa_id"], name: "FKpre_Pes_1_FK", using: :btree
  end

  create_table "proposta", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "texto",             limit: 50, null: false
    t.integer "estado",                       null: false
    t.bigint  "data_abertura",                null: false
    t.bigint  "data_encerramento"
    t.bigint  "pessoa_id",                    null: false
    t.index ["pessoa_id"], name: "FKFaz_FK", using: :btree
  end

  create_table "publica", primary_key: "proposta_id", id: :bigint, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "leilao_destino_id", null: false
    t.index ["leilao_destino_id"], name: "FKRecebe1_FK", using: :btree
  end

  create_table "tag", id: :bigint, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "nome", limit: 50, null: false
  end

  create_table "tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "troca", id: :bigint, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "estado",            limit: 10, null: false
    t.bigint "data_encerramento"
  end

  add_foreign_key "associa_se", "item", name: "FKAss_Ite"
  add_foreign_key "associa_se", "tag", name: "FKAss_Tag_FK"
  add_foreign_key "avaliacao", "pessoa", column: "destinatario_id", name: "FKPossui_FK"
  add_foreign_key "avaliacao", "troca", name: "FKTem_FK"
  add_foreign_key "deseja", "item", name: "FKDes_Ite_FK"
  add_foreign_key "deseja", "pessoa", name: "FKDes_Pes"
  add_foreign_key "envolve", "item", name: "FKEnv_Ite_FK"
  add_foreign_key "envolve", "proposta", column: "proposta_id", name: "FKEnv_Pro"
  add_foreign_key "item", "categoria", column: "categoria_id", name: "FKSe_enquadra_FK"
  add_foreign_key "item", "pessoa", column: "dono_id", name: "FKTem_Item_FK"
  add_foreign_key "leilao", "pessoa", name: "FKComeca_FK"
  add_foreign_key "leilao", "publica", column: "vencedora_id", primary_key: "proposta_id", name: "GRLeilao"
  add_foreign_key "oferta", "item", name: "FKofe_Ite_FK"
  add_foreign_key "oferta", "leilao", name: "FKofe_Lei"
  add_foreign_key "pessoal", "pessoa", column: "destinatario_id", name: "FKRecebe_FK"
  add_foreign_key "pessoal", "proposta", column: "proposta_id", name: "FKPro_Pes_FK"
  add_foreign_key "prefere_caracteristicas", "pessoa", name: "FKpre_Pes_FK"
  add_foreign_key "prefere_caracteristicas", "tag", name: "FKpre_Tag"
  add_foreign_key "prefere_categorias", "categoria", column: "categoria_id", name: "FKpre_Cat"
  add_foreign_key "prefere_categorias", "pessoa", name: "FKpre_Pes_1_FK"
  add_foreign_key "proposta", "pessoa", name: "FKFaz_FK"
  add_foreign_key "publica", "leilao", column: "leilao_destino_id", name: "FKRecebe1_FK"
  add_foreign_key "publica", "proposta", column: "proposta_id", name: "FKPro_Pub_FK"
  add_foreign_key "troca", "proposta", column: "id", name: "FKGera_FK"
end
