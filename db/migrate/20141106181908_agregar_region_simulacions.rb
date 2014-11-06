class AgregarRegionSimulacions < ActiveRecord::Migration
  def change
    add_column :simulacions, :region, :text
  end
end
