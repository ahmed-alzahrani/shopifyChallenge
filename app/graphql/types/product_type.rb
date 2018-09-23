Types::ProductType = GraphQL::ObjectType.define do
  name 'Product'

  description "A type that represents a single product in the SQLite database.

  id: The unique id of the product in the database. \n
  store_id: The unique id of the store that the product is sold by. \n
  name: The name of the product. \n
  value: A float represnting the base cost of the product. \n
  tags: A string representing the various sub-categories that products can be searched by. \n
  items: An array of items that represent different variations on the base product. \n
  "

  #it has the following fields
  field :id, !types.ID
  field :store_id, !types.ID
  field :name, !types.String
  field :value, !types.Float
  field :tags, !types.String
  field :items, !types[Types::ItemType]
end
