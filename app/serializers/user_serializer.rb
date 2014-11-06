class UserSerializer < ActiveModel::Serializer
  attributes :id,:username
  has_one :dato, key: :dato_attributes
end
