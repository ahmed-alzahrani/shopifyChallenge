class Resolvers::DeleteStore < GraphQL::Function

  description " A mutation that deletes a store form the SQLite database

  Arguments: \n \n
  token (required): An auth-token representing the user attempting to delete the store
  id (requred): The unique id of the store to be deleted. \n \n \n

  ERRORS IF: \n \n
  - The store id passed in is invalid (The store you are attempting to delete does not exist).
  - The authentication token passed in does not represent the owner of the store.
  "

  # required args
  argument :id, !types.ID
  argument :token, !types.String

  # return type
  type Types::StoreType

  def call(_obj, args, _ctx)
    # retrieve the records pertaining to the requesting user and the store to be deleted
    req = User.find_for_database_authentication(authentication_token: args[:token])
    store = Store.find_by(id: args[:id])

    if store
      if (req && req.id == store.user_id && req.owner)
        store.destroy
      else
        GraphQL::ExecutionError.new("You do not have permission to delete this store.")
      end
    else
      GraphQL::ExecutionError.new("The store you are attempting to delete does not exist.")
    end

  end
end
