class CambiarDecimalDoubleRadiacions < ActiveRecord::Migration
  def change
    change_column :radiacions, :long_sep, :double
    change_column :radiacions, :rad_costa, :double
    change_column :radiacions, :rad_cord, :double
  end
end
