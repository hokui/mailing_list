class MemberSerializer < ActiveModel::Serializer
  attributes :name,
             :email,
             :email_sub,
             :errors
end
