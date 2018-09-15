Types::ProductType = GraphQL::ObjectType.define do
  name 'Product'

  #it has the follownig fields
  field :id, !types.ID
  field :name, !types.String
  field :value, !types.Float
  # field :tags, types[!types.String]
  field :tags, !types.String
end
