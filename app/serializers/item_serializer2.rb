class ItemSerializer2 < ActiveModel::Serializer
    attributes :id, :abreviacion, :descripcion, :color, :nombre_usuario, :bloque
  def nombre_usuario
    if object.user
      if object.user.dato
        return object.user.dato.nombre
      end
    end
  end
end
