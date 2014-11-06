class CambiarDoubleCostos < ActiveRecord::Migration
  def change
      change_column :costos, :inv_UFPC, :double
      change_column :costos, :inv_FPC, :double
      change_column :costos, :inv_ETC, :double
      change_column :costos, :inv_PTC, :double
      change_column :costos, :m_inv_UFPC, :double
      change_column :costos, :m_inv_FPC, :double
      change_column :costos, :m_inv_ETC, :double
      change_column :costos, :m_inv_PTC, :double
      change_column :costos, :mant_UFPC, :double
      change_column :costos, :mant_FPC, :double
      change_column :costos, :mant_ETC, :double
      change_column :costos, :mant_PTC, :double
      change_column :costos, :acum, :double
  end
end
