class Resolvers::CreateItem < GraphQL::Function

  description " A mutation that creates a new item in the SQLite database. \n

  ARGUMENTS: \n \n
  token (reqired): An authentication-token representing the user making the request. Only owners have the rights to this mutation. \n
  storeId (required): A unique id representing the store that this item will belong to. \n
  productId (required): A unique product id representing the id of the product this item is a variation of. \n
  name (required): A string representing the name of the new item. \n
  value (required): A float representing the new item\'s price. \n \n \n

  ERRORS IF: \n \n
  - Any required arguments are missing, or any argument is passed as an invalid type. \n
  - The token passed in does not belong to an owner (You do not have owner rights to create new items) \n
  - The storeId passed in is invalid (You are attempting to add an item to a store that does not exist.) \n
  - The productId passed in is invalid (You are attempting to add an item to a product that does not exist.) \n
  - The value of an item is less than the value of its product (You can not create an item at less than the value of its product.) \n
  "

  # required arguments
  argument :token, !types.String
  argument :storeId, !types.ID
  argument :productId, !types.ID
  argument :name, !types.String
  argument :value, !types.Float

  # return type
  type Types::ItemType

  def call(_obj, args, _ctx)
    # find the records pertaining to the requesting user, the targeted product, and store
    req = User.find_for_database_authentication(authentication_token: args[:token])
    product = Product.find_by(id: args[:productId])
    store = Store.find_by(id: args[:storeId])

    # verify the requesting user exists and is an owner exists
    if req && req.owner
      # verify the store exists
      if store
        # verify that the product exists
        if product
          # verify that the item's value is greater than or equal to it's base product's value
          if args[:value] >= product.value
            # create the item if all checks pass
            Item.create!(
              product_id: args[:productId],
              name: args[:name],
              value: args[:value]
            )
            # various errors resulting from any of the above checks failing
          else
            GraphQL::ExecutionError.new("You can not create an item at less than the value of its product.")
          end
        else
          GraphQL::ExecutionError.new("You are attempting to add an item to a product that does not exist.")
        end
      else
        GraphQL::ExecutionError.new("You are attempting to add an item to a store that does not exist.")
      end
    else
      GraphQL::ExecutionError.new("You do not have owner rights to create new items")
    end

  end
end
