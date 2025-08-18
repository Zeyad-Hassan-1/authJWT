class UserSerializer < ActiveModel::Serializer
  attributes :username, :bio, :admin
end