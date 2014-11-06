class PermisoSerializer < ActiveModel::Serializer
  attributes :id,:usuario, :user_id, :proyecto_id, :valor, :valor_texto
  def usuario
      object.user.dato.nombre
  end
  def valor_texto
    if(object.valor==2)
      return "ver"
    end
    if(object.valor==1)
      return "editar"
    end
  end
end
