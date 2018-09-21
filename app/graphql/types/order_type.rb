Types::OrderType = GraphQL::ObjectType.define do
  name 'Order'

  field :id, !types.ID
  field :subTotal, !types.Float
  field :savings, !types.Float
  field :tax, !types.Float
  field :total, !types.Float
  field :store_id, !types.ID
  field :user_id, !types.ID
  field :items, !types[Types::ItemType]
end
