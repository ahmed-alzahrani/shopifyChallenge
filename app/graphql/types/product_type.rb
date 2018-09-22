Types::ProductType = GraphQL::ObjectType.define do
  name 'Product'

  #it has the follownig fields
  field :id, !types.ID
  field :store_id, !types.ID
  field :name, !types.String
  field :value, !types.Float
  field :tags, !types.String
  field :items, !types[Types::ItemType]
end
