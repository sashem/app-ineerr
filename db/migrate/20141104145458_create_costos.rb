class CreateCostos < ActiveRecord::Migration
  def change
    create_table :costos do |t|
      t.string :coef
      t.decimal :inv_UFPC
      t.decimal :inv_FPC
      t.decimal :inv_ETC
      t.decimal :inv_PTC
      t.decimal :m_inv_UFPC
      t.decimal :m_inv_FPC
      t.decimal :m_inv_ETC
      t.decimal :m_inv_PTC
      t.decimal :mant_UFPC
      t.decimal :mant_FPC
      t.decimal :mant_ETC
      t.decimal :mant_PTC
      t.decimal :acum
      
      t.timestamps
    end
  end
end
