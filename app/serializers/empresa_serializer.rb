class EmpresaSerializer < ActiveModel::Serializer
  attributes :id, :nombre, :contacto, :email
  has_many :simulacions, key: :simulacions
end
