class Empresa < ActiveRecord::Base
  validates :email, uniqueness: {:message => "El mail ya está registrado"}
  validates :nombre, uniqueness: {:message => "El nombre de la empresa ya está registrado"}
  has_many :simulacions
  accepts_nested_attributes_for :simulacions
end
