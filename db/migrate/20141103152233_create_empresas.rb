class CreateEmpresas < ActiveRecord::Migration
  def change
    create_table :empresas do |t|
      t.string :nombre
      t.string :contacto
      t.string :email
      t.string :pass

      t.timestamps
    end
  end
end
