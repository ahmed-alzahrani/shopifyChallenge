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

  argument :token, !types.String
  argument :id, !types.ID
  argument :productId, !types.ID

  argument :name, types.String
  argument :value, types.Float

  type Types::ItemType

  def call(_obj, args, _ctx)
    req = User.find_for_database_authentication(authentication_token: args[:token])
    target = Item.find_by(id: args[:id])
    product = Product.find_by(id: args[:productId])

    if product && target
      if req && req.owner
        obj = {}

        if args[:name]
          obj[:name] = args[:name]
        end

        if args[:value] && args[:value] >= product.value
          obj[:value] = args[:value]
        end

        if obj == {}
          # GraphQL::ExecutionError.new("Improper query. Please specify at least one change you wish to make.")
          return target
        end
        target.update!(obj)
        target
      else
        GraphQL::ExecutionError.new("You do not have permission to update items.")
      end
    else
      GraphQL::ExecutionError.new("You are attempting to update an item that does not exist.")
    end
  end
end
