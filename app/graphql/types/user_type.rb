Types::UserType = GraphQL::ObjectType.define do
  name 'User'
  description 'Example User'

  field :id, !types.ID
  field :last_name, !types.String
  field :first_name, !types.String
  field :email, !types.String
  field :owner, !types.Boolean
end