class CambiarRubroSimulacion < ActiveRecord::Migration
  def change
    change_column :simulacions, :rubro, :string
  end
end
