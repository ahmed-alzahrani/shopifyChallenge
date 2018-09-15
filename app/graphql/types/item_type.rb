Types::ItemType = GraphQL::ObjectType.define do
  name 'Item'

  #it has the follownig fields
  field :id, !types.ID
  field :name, !types.String
  field :value, !types.Float
  field :product_id, !types.ID
end
