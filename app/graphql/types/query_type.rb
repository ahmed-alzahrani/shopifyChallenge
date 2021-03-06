Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'

  description 'Here contain all of the queries that can be made through this API.
  These include queries for the current user (getMe), as well as searches for
  the orders, products, stores, and users that exist in SQLite DB. These latter
  queries all have optional parameters that allow users to filter their requests.'

  # Store query
  field :stores do

    description 'A query that returns a sub-set of the exsiting
    stores based on which optional args are past in.
    If none are specified, all stores will be returned.'

    # return type
    type !types[Types::StoreType]

    # all args are optional
    argument :id, types.ID
    argument :name, types.String
    argument :email, types.String
    argument :phone, types.String
    argument :url, types.String
    argument :orderCount, types.Int
    argument :totalSold, types.Float
    argument :userId, types.ID

    # return all stores if no optional args are present, or stores filtered by those args
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

  # user query
  field :users do

    description 'A query that returns a sub-set of the exsiting
    stores based on which optional args are past in.
    If none are specified, all stores will be returned.

    Querying the users requires presence of an auth-token as a required argument,
    and will error if the token does not belong to an owner.'

    # return type
    type !types[Types::UserType]

    # required arg
    argument :token, !types.String

    # optional args
    argument :id, types.ID
    argument :firstName, types.String
    argument :lastName, types.String
    argument :email, types.String
    argument :owner, types.Boolean
    argument :orderCount, types.Int
    argument :totalSpent, types.Float

    resolve -> (obj, args, ctx) {
        # verify that the requesting user has owner privileges to query users
        user = User.find_for_database_authentication(authentication_token: args[:token])
        if user && user.owner

          # return all users if no optional args are present, or users filtered by those args

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

    description 'A query that takes in an auth-token and returns the user that token corresponds to.'

    # required argument
    argument :token, !types.String

    # if a user exists with the passed in token, return that user, else error
    resolve -> (obj, args, ctx) {
      user = User.find_for_database_authentication(authentication_token: args[:token])
      if user
        user
      else
        GraphQL::ExecutionError.new("You must login before requesting your own customer profile")
      end

    }
  end

  # order query
  field :orders do

    description 'A query that returns a sub-set of the exsiting
    orders based on which optional args are past in.
    If none are specified, all orders will be returned.

    Querying the orders requires presence of an auth-token as a required argument,
    and will error if the token does not belong to an owner.'

    # return type
    type !types[Types::OrderType]

    # required arg
    argument :token, !types.String

    # optional params
    argument :userId, types.ID
    argument :storeId, types.ID
    argument :lessThan, types.Float
    argument :moreThan, types.Float

    # retrieve and verify that the requesting user exists and has owner rights
    resolve -> (obj, args, ctx) {
        user = User.find_for_database_authentication(authentication_token: args[:token])
        if user && user.owner
          # return all orders if no optional args are present, or orders filtered by those args
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

  # product query (also returns relevant items)

  field :products do
    type !types[Types::ProductType]

    description 'A query that returns a sub-set of the exsiting
    products based on which optional args are past in.
    If none are specified, all products will be returned.'

    # optional args
    argument :id, types.ID
    argument :storeId, types.ID
    argument :name, types.String
    argument :tags, types.String
    argument :value, types.Float

    # return all products if no optional args are present, or products filtered by those args
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
