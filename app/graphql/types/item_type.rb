Types::ItemType = GraphQL::ObjectType.define do
  name 'Item'

  description "A type that represents a single item in the SQLite database.

  id: The unique id of the order in the database. \n
  name: A string representing the name of the item. \n
  value: A float value representing the cost of this item. \n
  product_id: The unique id that belongs to the product that this item is a variation of. \n
  "

  #it has the follownig fields
  field :id, !types.ID
  field :name, !types.String
  field :value, !types.Float
  field :product_id, !types.ID
end
