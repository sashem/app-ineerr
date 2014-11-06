class AgregarCamposSimluacions < ActiveRecord::Migration
  def change
    add_column :simulacions, :antiguedad, :int
    add_column :simulacions, :recuperacion, :boolean
    add_column :simulacions, :consumo_electrico_general, :double
    add_column :simulacions, :unidad_consumo_electrico_general, :int
    add_column :simulacions, :consumo_minimo, :double
    add_column :simulacions, :unidad_consumo_minumo, :int
  end
end
