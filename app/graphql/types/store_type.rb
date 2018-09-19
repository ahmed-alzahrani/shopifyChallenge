Types::StoreType = GraphQL::ObjectType.define do
  name 'Store'

  #it has the following fields
  field :id, !types.ID
  field :name, !types.String
  field :email, !types.String
  field :phone, !types.String
  field :url, !types.String
  field :user_id, !types.ID

end
