class DatoSerializer < ActiveModel::Serializer
  attributes :nombre, :apellido, :mail, :edad
end
