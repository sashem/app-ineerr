class CreateRadiacions < ActiveRecord::Migration
  def change
    create_table :radiacions do |t|
      t.string :nombre_region
      t.float :long_sep
      t.float :rad_costa
      t.float :rad_cord
 
      t.timestamps
    end
  end
end
