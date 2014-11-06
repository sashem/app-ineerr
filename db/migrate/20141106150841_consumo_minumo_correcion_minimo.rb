class ConsumoMinumoCorrecionMinimo < ActiveRecord::Migration
  def change
    add_column :simulacions, :unidad_consumo_minimo, :int
  end
end
