class CambioIntDoubleSimulacions < ActiveRecord::Migration
  def change
    add_column :simulacions, :combustible, :int
    change_column :simulacions, :consumo, :double
    change_column :simulacions, :consumo_electrico, :double
    change_column :simulacions, :cop, :double
    change_column :simulacions, :eficiencia, :double
    change_column :simulacions, :precio_combustible, :double
    change_column :simulacions, :precio_electricidad, :double
    change_column :simulacions, :superficie, :double
  end
end
