require 'search_object'
require 'search_object/plugin/graphql'

Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'

  # product/item queries
  field :products, function: Resolvers::ProductsSearch

  field :allProducts, !types[Types::ProductType] do
    resolve -> (obj, args, ctx) { Product.all }
  end

  field :allItems, !types[Types::ItemType] do
    resolve -> (obj, args, ctx) { Item.all }
  end

  # user queries
  field :allUsers, !types[Types::UserType] do
    resolve -> (obj, args, ctx) { User.all }
  end
end
