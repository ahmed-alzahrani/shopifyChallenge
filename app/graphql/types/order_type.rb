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



=begin
  argument :items, !types[types.ID]


return OpenStruct.new(
  id: order.id,
  subTotal: order.subTotal,
  savings: order.savings,
  tax: order.tax,
  total: order.total,
  store_id: order.store_id,
  user_id: order.user_id,
  items: order_items
)
=end
