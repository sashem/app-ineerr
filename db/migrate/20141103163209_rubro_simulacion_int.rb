class RubroSimulacionInt < ActiveRecord::Migration
  def change
    remove_column :simulacions, :rubro
    add_column :simulacions, :rubro, :int
  end
end
