class MemberSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :email,
             :email_sub,
             :errors
end
