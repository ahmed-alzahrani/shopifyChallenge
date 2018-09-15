require 'search_object'
require 'search_object/plugin/graphql'

Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'

  field :products, function: Resolvers::ProductsSearch

  #queries are just represented as fields
  field :allProducts, !types[Types::ProductType] do
    resolve -> (obj, args, ctx) { Product.all }
  end

  field :allItems, !types[Types::ItemType] do
    resolve -> (obj, args, ctx) { Item.all }
  end

end
