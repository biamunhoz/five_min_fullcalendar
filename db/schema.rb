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

ActiveRecord::Schema.define(version: 2020_07_27_193043) do

  create_table "agendas", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "nome"
    t.boolean "apresentacaotelaini"
    t.string "observacao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "tipo"
  end

  create_table "events", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.string "string"
    t.string "body"
    t.string "start_date"
    t.string "datetime"
    t.string "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inscricaos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "usuario_id"
    t.bigint "agenda_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agenda_id"], name: "index_inscricaos_on_agenda_id"
    t.index ["usuario_id"], name: "index_inscricaos_on_usuario_id"
  end

  create_table "perfils", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "nomeperfil"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "permissaos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "usuarios_id"
    t.bigint "salas_id"
    t.bigint "perfils_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["perfils_id"], name: "index_permissaos_on_perfils_id"
    t.index ["salas_id"], name: "index_permissaos_on_salas_id"
    t.index ["usuarios_id"], name: "index_permissaos_on_usuarios_id"
  end

  create_table "salas", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "nome"
    t.string "cor"
    t.boolean "permissaoauto"
    t.text "observacao"
    t.boolean "confirmacao"
    t.bigint "agendas_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agendas_id"], name: "index_salas_on_agendas_id"
  end

  create_table "tipo_vinculos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "tipoVinculo"
    t.string "codigoSetor"
    t.string "nomeAbreviadSetor"
    t.string "nomeSetor"
    t.string "codigoUnidade"
    t.string "siglaUnidade"
    t.string "nomeUnidade"
    t.string "nomeVinculo"
    t.string "nomeAbreviadoFuncao"
    t.bigint "usuario_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["usuario_id"], name: "index_tipo_vinculos_on_usuario_id"
  end

  create_table "usuarios", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "nomeUsuario"
    t.string "loginUsuario"
    t.string "tipoUsuario"
    t.string "emailPrincipalUsuario"
    t.string "emailAlternativoUsuario"
    t.string "emailUspUsuario"
    t.string "numeroTelefoneFormatado"
    t.string "ramalUsp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "inscricaos", "agendas"
  add_foreign_key "inscricaos", "usuarios"
  add_foreign_key "permissaos", "perfils", column: "perfils_id"
  add_foreign_key "permissaos", "salas", column: "salas_id"
  add_foreign_key "permissaos", "usuarios", column: "usuarios_id"
  add_foreign_key "salas", "agendas", column: "agendas_id"
  add_foreign_key "tipo_vinculos", "usuarios"
end
