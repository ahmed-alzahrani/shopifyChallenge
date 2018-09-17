Types::AuthType = GraphQL::ObjectType.define do
  name 'AuthType'

  field :authenticationToken, !types.String, property: :authentication_token
end
