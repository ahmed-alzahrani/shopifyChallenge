class Resolvers::UpdateItem < GraphQL::Function

  description" A mutation that updates an item from the SQLite database. Only owners can update items. If no optional args are passed,
  the item remains unchanged and is returned in it\'s current state.

  ARGUMENTS: \n \n
  token (required): An authentication token passed in by the requesting user.\n
  id (required): The unique id of the item being updated.\n
  productId (required): The unique id of the product that the item being updated is a variation of.\n
  name (optional): The new name of the updated item if being changed.\n
  value (optional): The new value of the updated item if being changed. \n \n \n

  ERRORS IF: \n \n
  - The item id passed in is invalid. (You are attempting to update an item that does not exist.) \n
  - The authentication token passed in does not correspond to an owner. (You do not have permission to update items). \n
  "

  # arguments passed in

  # required args
  argument :token, !types.String
  argument :id, !types.ID
  argument :productId, !types.ID

  # optional args
  argument :name, types.String
  argument :value, types.Float

  # return type
  type Types::ItemType

  def call(_obj, args, _ctx)
    # retrieve the record pertaining to the requesting user, the item we want to update and its product
    req = User.find_for_database_authentication(authentication_token: args[:token])
    target = Item.find_by(id: args[:id])
    product = Product.find_by(id: args[:productId])

    # verify that the product and target item exist
    if product && target

      # verify that the requesting user exists and has ownership rights
      if req && req.owner

        # if so instantiate our 'update hash' as empty
        obj = {}

        # go through each optional argument, and if it has been passed in, add it to our update hash
        if args[:name]
          obj[:name] = args[:name]
        end

        if args[:value] && args[:value] >= product.value
          obj[:value] = args[:value]
        end

        # if the update hash is empty, return the unchanged item
        if obj == {}
          return target
        end
        # else update the item and return it
        target.update!(obj)
        target
      # error if any of the prior checks failed
      else
        GraphQL::ExecutionError.new("You do not have permission to update items.")
      end
    else
      GraphQL::ExecutionError.new("You are attempting to update an item that does not exist.")
    end
  end
end
