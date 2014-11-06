class QqtfftRubros < ActiveRecord::Migration
  def change
    add_column :rubros, :QQT, :double
    add_column :rubros, :FFT, :double
  end
end
