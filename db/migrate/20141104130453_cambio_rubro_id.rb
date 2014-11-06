class CambioRubroId < ActiveRecord::Migration
  def change
    change_column :rubros, :rubro_id, :string
  end
end
