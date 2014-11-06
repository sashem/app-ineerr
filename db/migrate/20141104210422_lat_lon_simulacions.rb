class LatLonSimulacions < ActiveRecord::Migration
  def change
    add_column :simulacions, :nombre, :string
    add_column :simulacions, :latitud, :float
    add_column :simulacions, :longitud, :float
  end
end
