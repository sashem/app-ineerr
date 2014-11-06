class ProyectoSerializer < ActiveModel::Serializer
  attributes :id, :nombre, :descripcion,:created_at, :editable, :updated_at
  has_many :permisos, key: :permisos_attributes
  def editable
    if(object.permisos.where(:user_id=>current_user.id).exists?)
      if(object.permisos.find_by(:user_id=>current_user.id).valor>=2)
        return false
      else
        return true  
      end
      
      else
        if(object.user_id==current_user.id)
          return true
        else
          return false
        end
    end
  end
end
