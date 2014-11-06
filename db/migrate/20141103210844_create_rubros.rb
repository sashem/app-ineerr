class CreateRubros < ActiveRecord::Migration
  def change
    create_table :rubros do |t|
      t.string :rubro_id
      t.integer :C_UFPC_B
      t.integer :C_UFPC_C
      t.integer :C_FPC_B
      t.integer :C_FPC_C
      t.integer :C_ETC_B
      t.integer :C_ETC_C
      t.integer :C_PTC_B
      t.integer :C_PTC_C
      t.integer :F_UFPC_A
      t.integer :F_UFPC_B
      t.integer :F_FPC_A
      t.integer :F_FPC_B
      t.integer :F_ETC_A
      t.integer :F_ETC_B
      t.integer :F_PTC_A
      t.integer :F_PTC_B
      
      t.timestamps
    end
  end
end
