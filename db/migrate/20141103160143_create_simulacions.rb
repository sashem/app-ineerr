class CreateSimulacions < ActiveRecord::Migration
  def change
    create_table :simulacions do |t|
      t.integer :empresa_id
      t.integer :tecnologia
      t.integer :consumo
      t.integer :consumo_electrico
      t.integer :cop
      t.integer :eficiencia
      t.integer :precio_combustible
      t.integer :precio_electricidad
      t.integer :superficie
      t.integer :superficie_lugar
      t.integer :unidad_consumo
      t.integer :unidad_consumo_electrico
      t.integer :unidad_precio_combustible

      t.timestamps
    end
  end
end
