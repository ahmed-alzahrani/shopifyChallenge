require 'search_object'
require 'search_object/plugin/graphql'

Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'

  # STORE QUERIES

  # returns all stores
  field :allStores, !types[Types::StoreType] do
    resolve -> (obj, args, ctx) { Store.all }
  end

  # USER QUERIES

  # allows owners to search users by any filter
  field :users, function: Resolvers::UsersSearch

  # gets all users if a proper token is passed in
  field :allUsers, !types[Types::UserType] do
    argument :token, !types.String
    resolve -> (obj, args, ctx) {
      user = User.find_for_database_authentication(authentication_token: args[:token])
      if (user && user.owner)
        User.all
      else
        GraphQL::ExecutionError.new("You do not have the rights to view all the users")
      end
     }
  end

  # returns ONLY the user who is logged in
  field :getMe, Types::UserType do
    argument :token, !types.String
    resolve -> (obj, args, ctx) {
      user = User.find_for_database_authentication(authentication_token: args[:token])
      if user
        user
      else
        GraphQL::ExecutionError.new("You must login before requesting your own customer profile")
      end

    }
  end

  # ORDER QUERIES
  field :allOrders, Types::OrderType do
    argument :token, !types.String
    resolve -> (obj, args, ctx) {
      user = User.find_for_database_authentication(authentication_token: args[:token])
      if (user && user.owner)
        Order.all
      else
        GraphQL::ExecutionError.new("You do not have the rights to view all the orders")
      end
    }
  end

  # PRODUCT QUERIES

  # allows owners to search products by any filter
  field :products, function: Resolvers::ProductsSearch

  # returns ALL products
  field :allProducts, !types[Types::ProductType] do
    resolve -> (obj, args, ctx) { Product.all }
  end

  field :allItems, !types[Types::ItemType] do
    resolve -> (obj, args, ctx) { Item.all }
  end

  #ITEMS QUERIES


end
