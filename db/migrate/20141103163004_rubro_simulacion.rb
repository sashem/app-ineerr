class RubroSimulacion < ActiveRecord::Migration
  def change
    add_column :simulacions, :rubro, :string
  end
end
