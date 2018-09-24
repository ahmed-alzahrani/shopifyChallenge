class Resolvers::DeleteItem < GraphQL::Function

  description " A mutation that deletes an item from the the SQLite database. \n

  ARGUMENTS: \n \n
  token (required): An authentication-token representing the user making the request. Only owners can create items. \n
  id (required): The id of the item to be deleted. \n \n \n

  ERRORS IF: \n \n
  - Any required arguments are missing, or any argument is passed as an invalid type. \n
  - The item id passed in is invalid. (The item you are attempting to delete does not exist.) \n
  - The authentication token passed in does not represent an owner. (you do not have permission to delete items). \n
  "

  # required args
  argument :id, !types.ID
  argument :token, !types.String

  # return type
  type Types::ItemType

  def call(_obj, args, _ctx)
    # retrieve the records pertaining to the requesting user and the item to be deleted
    req = User.find_for_database_authentication(authentication_token: args[:token])
    item = Item.find_by(id: args[:id])
    # if the item exists
    #if Item.exists?(args[:id])
    if item
      # and the requesting user both exists and is an owner
      if req && req.owner
        # destory the item
        item.destroy
      # else we error if any of the prior checks failed
      else
        GraphQL::ExecutionError.new("You do not have permission to delete items.")
      end
    else
      GraphQL::ExecutionError.new("The item you are attempting to delete does not exist.")
    end
  end
end
