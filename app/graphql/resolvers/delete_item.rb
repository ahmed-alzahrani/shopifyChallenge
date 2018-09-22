class Resolvers::DeleteItem < GraphQL::Function

  description " A mutation that deletes an item from the the SQLite database. \n

  ARGUMENTS: \n \n
  token (required): An authentication-token representing the user making the request. Only owners can create items. \n
  id (required): The id of the item to be deleted. \n \n \n

  ERRORS IF: \n \n
  - The item id passed in is invalid. (The item you are attempting to delete does not exist.) \n
  - The authentication token passed in does not represent an owner. (you do not have permission to delete items). \n
  "

  argument :id, !types.ID
  argument :token, !types.String

  type Types::ItemType

  def call(_obj, args, _ctx)
    req = User.find_for_database_authentication(authentication_token: args[:token])
    item = Item.find(args[:id])
    if item
      if req && req.owner
        item.destroy
      else
        GraphQL::ExecutionError.new("You do not have permission to delete items.")
      end
    else
      GraphQL::ExecutionError.new("The item you are attempting to delete does not exist.")
    end
  end
end
