Types::OrderType = GraphQL::ObjectType.define do
  name 'Order'

  description "A type that represents a single order in the SQLite database.

  id: The unique id of the order in the database. \n
  subTotal: The subtotal float value calculated by adding the values of all the items that make up the order. \n
  adjusted: The subtotal of the order, adjusted for the various discounts users may redeem. \n
  savings: A float represnting the amount saved on this order via discounts. (subtotal - adjusted = savings) \n
  tax: A float representing the amount of tax payed on this order. (all orders taxed at 13%) \n
  total: A float representing the total cost of the order. (total = adjusted + tax) \n
  store_id: The unique id of the store that sold this particular order. \n
  user_id: The unique id of the store that purchased this particular order. \n
  items: An array of items that represent the items sold as part of this order. \n
  "

  field :id, !types.ID
  field :subTotal, !types.Float
  field :adjusted, !types.Float
  field :savings, !types.Float
  field :tax, !types.Float
  field :total, !types.Float
  field :store_id, !types.ID
  field :user_id, !types.ID
  field :items, !types[Types::ItemType]
end
