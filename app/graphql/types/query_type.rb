require 'search_object'
require 'search_object/plugin/graphql'

Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'

  # STORE QUERIES
  field :stores do
    type !types[Types::StoreType]

    argument :id, types.ID
    argument :name, types.String
    argument :email, types.String
    argument :phone, types.String
    argument :url, types.String
    argument :orderCount, types.Int
    argument :totalSold, types.Float
    argument :userId, types.ID

    resolve -> (obj, args, ctx) {
      if args[:id]
        Store.where(id: args[:id])
      elsif args[:name]
        Store.where("name like ?", "%#{args[:name]}%")
      elsif args[:email]
        Store.where("email like ?", "%#{args[:email]}%")
      elsif args[:phone]
        Store.where("phone like ?", "%#{args[:phone]}%")
      elsif args[:url]
        Store.where("url like ?", "%#{args[:url]}%")
      elsif args[:orderCount]
        Store.where(order_count: args[:orderCount])
      elsif args[:totalSold]
        Store.where(total_sold: args[:totalSold])
      elsif args[:userId]
        Store.where(user_id: args[:userId])
      else
        Store.all
      end
    }
  end

  # USER QUERIES
  field :users do
    type !types[Types::UserType]

    argument :token, !types.String
    argument :id, types.ID
    argument :firstName, types.String
    argument :lastName, types.String
    argument :email, types.String
    argument :owner, types.Boolean
    argument :orderCount, types.Int
    argument :totalSpent, types.Float

    resolve -> (obj, args, ctx) {
        user = User.find_for_database_authentication(authentication_token: args[:token])
        if user && user.owner
          if args[:id]
            User.where(id: args[:id])
          elsif args[:firstName]
            User.where("first_name like ?", "%#{args[:firstName]}%")
          elsif args[:lastName]
            User.where("last_name like ?", "%#{args[:lastName]}%")
          elsif args[:email]
            User.where("email like ?", "%#{args[:email]}%")
          elsif (args[:owner] != nil)
            User.where(owner: args[:owner])
          elsif args[:orderCount]
            User.where(order_count: args[:orderCount])
          elsif args[:totalSpent]
            User.where(total_spent: args[:totalSpent])
          else
            User.all
          end
        else
          GraphQL::ExecutionError.new("You do not have the rights to view all the orders")
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

  field :orders do
    type !types[Types::OrderType]

    argument :token, !types.String
    argument :userId, types.ID
    argument :storeId, types.ID
    argument :lessThan, types.Float
    argument :moreThan, types.Float

    resolve -> (obj, args, ctx) {
        user = User.find_for_database_authentication(authentication_token: args[:token])
        if user && user.owner
          if args[:userId]
            Order.where(user_id: args[:userId])
          elsif args[:storeId]
            Order.where(store_id: args[:storeId])
          elsif args[:lessThan]
            Order.where("total" <= args[:lessThan])
          elsif args[:moreThan]
            Order.where("total" > args[:moreThan])
          else
            Order.all
          end
        else
          GraphQL::ExecutionError.new("You do not have the rights to view all the orders")
        end
    }
  end

  # PRODUCT QUERIES / (ALSO INCLUDES RELEVANT ITEMS)

  field :products do
    type !types[Types::ProductType]

    argument :id, types.ID
    argument :storeId, types.ID
    argument :name, types.String
    argument :tags, types.String
    argument :value, types.Float

    resolve -> (obj, args, ctx) {
      if args[:id]
        Product.where(id: args[:id])
      elsif args[:storeId]
        Product.where(store_id: args[:storeId])
      elsif args[:name]
        Product.where("name like ?", "%#{args[:name]}%")
      elsif args[:tags]
        Product.where(tags: args[:tags])
      elsif args[:value]
        Product.where(value: args[:value])
      else
        Product.all
      end
    }

  end
end
