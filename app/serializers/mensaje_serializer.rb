class MensajeSerializer < ActiveModel::Serializer
  attributes :id,:contenido, :username, :usuario, :updated_at
  def username
      object.user.username
  end
  def usuario
      object.user.dato.nombre
  end
end
