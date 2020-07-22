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

ActiveRecord::Schema.define(version: 2020_07_22_173144) do

  create_table "agendas", force: :cascade do |t|
    t.string "nome"
    t.boolean "apresentacaotelaini"
    t.string "observacao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "agendas_salas", id: false, force: :cascade do |t|
    t.integer "agenda_id", null: false
    t.integer "sala_id", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.string "string"
    t.string "body"
    t.string "start_date"
    t.string "datetime"
    t.string "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "perfils", force: :cascade do |t|
    t.string "nomeperfil"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "permissaos", force: :cascade do |t|
    t.integer "usuarios_id"
    t.integer "salas_id"
    t.integer "perfils_id"
    t.index ["perfils_id"], name: "index_permissaos_on_perfils_id"
    t.index ["salas_id"], name: "index_permissaos_on_salas_id"
    t.index ["usuarios_id"], name: "index_permissaos_on_usuarios_id"
  end

  create_table "salas", force: :cascade do |t|
    t.string "nome"
    t.string "cor"
    t.boolean "permissaoauto"
    t.text "observacao"
    t.boolean "confirmacao"
    t.integer "agendas_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agendas_id"], name: "index_salas_on_agendas_id"
  end

  create_table "tipo_vinculos", force: :cascade do |t|
    t.string "tipoVinculo"
    t.string "codigoSetor"
    t.string "nomeAbreviadSetor"
    t.string "nomeSetor"
    t.string "codigoUnidade"
    t.string "siglaUnidade"
    t.string "nomeUnidade"
    t.string "nomeVinculo"
    t.string "nomeAbreviadoFuncao"
    t.integer "usuario_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["usuario_id"], name: "index_tipo_vinculos_on_usuario_id"
  end

  create_table "usuarios", force: :cascade do |t|
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

end
