# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141106163402) do

  create_table "costos", force: true do |t|
    t.string   "coef"
    t.float    "inv_UFPC",   limit: 53
    t.float    "inv_FPC",    limit: 53
    t.float    "inv_ETC",    limit: 53
    t.float    "inv_PTC",    limit: 53
    t.float    "m_inv_UFPC", limit: 53
    t.float    "m_inv_FPC",  limit: 53
    t.float    "m_inv_ETC",  limit: 53
    t.float    "m_inv_PTC",  limit: 53
    t.float    "mant_UFPC",  limit: 53
    t.float    "mant_FPC",   limit: 53
    t.float    "mant_ETC",   limit: 53
    t.float    "mant_PTC",   limit: 53
    t.float    "acum",       limit: 53
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "empresas", force: true do |t|
    t.string   "nombre"
    t.string   "contacto"
    t.string   "email"
    t.string   "pass"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "key"
  end

  create_table "hoja1", id: false, force: true do |t|
    t.string  "Rubro_id", limit: 4
    t.string  "C_UFPC_B", limit: 7
    t.string  "C_UFPC_C", limit: 6
    t.string  "C_FPC_B",  limit: 6
    t.string  "C_FPC_C",  limit: 6
    t.string  "C_ETC_B",  limit: 7
    t.string  "C_ETC_C",  limit: 6
    t.string  "C_PTC_B",  limit: 11
    t.string  "C_PTC_C",  limit: 9
    t.decimal "F_UFPC_A",            precision: 7, scale: 6
    t.decimal "F_UFPC_B",            precision: 7, scale: 6
    t.string  "F_FPC_A",  limit: 11
    t.string  "F_FPC_B",  limit: 11
    t.string  "F_ETC_A",  limit: 11
    t.string  "F_ETC_B",  limit: 11
    t.decimal "F_PTC_A",             precision: 7, scale: 6
    t.decimal "F_PTC_B",             precision: 7, scale: 6
  end

  create_table "radiacions", force: true do |t|
    t.string   "nombre_region"
    t.float    "long_sep",      limit: 24
    t.float    "rad_costa",     limit: 24
    t.float    "rad_cord",      limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rubros", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "rubro_id"
    t.float    "C_UFPC_B",   limit: 53
    t.float    "C_UFPC_C",   limit: 53
    t.float    "C_FPC_B",    limit: 53
    t.float    "C_FPC_C",    limit: 53
    t.float    "C_ETC_B",    limit: 53
    t.float    "C_ETC_C",    limit: 53
    t.float    "C_PTC_B",    limit: 53
    t.float    "C_PTC_C",    limit: 53
    t.float    "F_UFPC_A",   limit: 53
    t.float    "F_UFPC_B",   limit: 53
    t.float    "F_FPC_A",    limit: 53
    t.float    "F_FPC_B",    limit: 53
    t.float    "F_ETC_A",    limit: 53
    t.float    "F_ETC_B",    limit: 53
    t.float    "F_PTC_A",    limit: 53
    t.float    "F_PTC_B",    limit: 53
    t.float    "QQT",        limit: 53
    t.float    "FFT",        limit: 53
  end

  create_table "simulacions", force: true do |t|
    t.integer  "empresa_id"
    t.integer  "tecnologia"
    t.float    "consumo",                          limit: 53
    t.float    "consumo_electrico",                limit: 53
    t.float    "cop",                              limit: 53
    t.float    "eficiencia",                       limit: 53
    t.float    "precio_combustible",               limit: 53
    t.float    "precio_electricidad",              limit: 53
    t.float    "superficie",                       limit: 53
    t.integer  "superficie_lugar"
    t.integer  "unidad_consumo"
    t.integer  "unidad_consumo_electrico"
    t.integer  "unidad_precio_combustible"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "rubro"
    t.integer  "combustible"
    t.string   "nombre"
    t.float    "latitud",                          limit: 24
    t.float    "longitud",                         limit: 24
    t.integer  "antiguedad"
    t.boolean  "recuperacion"
    t.float    "consumo_electrico_general",        limit: 53
    t.integer  "unidad_consumo_electrico_general"
    t.float    "consumo_minimo",                   limit: 53
    t.integer  "unidad_consumo_minimo"
  end

end
