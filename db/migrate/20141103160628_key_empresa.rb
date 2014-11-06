class KeyEmpresa < ActiveRecord::Migration
  def change
    add_column :empresas, :key, :string
  end
end
