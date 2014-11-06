class IntDoubleRubros < ActiveRecord::Migration
  def change
    remove_column :rubros, :rubro_id
    remove_column :rubros, :C_UFPC_B
    remove_column :rubros, :C_UFPC_C
    remove_column :rubros, :C_FPC_B
    remove_column :rubros, :C_FPC_C
    remove_column :rubros, :C_ETC_B
    remove_column :rubros, :C_ETC_C
    remove_column :rubros, :C_PTC_B
    remove_column :rubros, :C_PTC_C
    remove_column :rubros, :F_UFPC_A
    remove_column :rubros, :F_UFPC_B
    remove_column :rubros, :F_FPC_A
    remove_column :rubros, :F_FPC_B
    remove_column :rubros, :F_ETC_A
    remove_column :rubros, :F_ETC_B
    remove_column :rubros, :F_PTC_A
    remove_column :rubros, :F_PTC_B
    
    add_column :rubros, :rubro_id, :int
    add_column :rubros, :C_UFPC_B, :double
    add_column :rubros, :C_UFPC_C, :double
    add_column :rubros, :C_FPC_B, :double
    add_column :rubros, :C_FPC_C, :double
    add_column :rubros, :C_ETC_B, :double
    add_column :rubros, :C_ETC_C, :double
    add_column :rubros, :C_PTC_B, :double
    add_column :rubros, :C_PTC_C, :double
    add_column :rubros, :F_UFPC_A, :double
    add_column :rubros, :F_UFPC_B, :double
    add_column :rubros, :F_FPC_A, :double
    add_column :rubros, :F_FPC_B, :double
    add_column :rubros, :F_ETC_A, :double
    add_column :rubros, :F_ETC_B, :double
    add_column :rubros, :F_PTC_A, :double
    add_column :rubros, :F_PTC_B, :double
    
  end
end
