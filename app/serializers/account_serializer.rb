class UserSerializer < ActiveModel::Serializer
  attributes :full_name, :email, :role
end
