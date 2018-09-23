class Resolvers::UpdateStore < GraphQL::Function

  description" A mutation that updates a store from the SQLite database. Only THE owner attached to the store owners can update it. If no optional args are passed,
  the store remains unchanged and is returned in it\'s current state.

  ARGUMENTS: \n \n
  token (required): An authentication token passed in by the requesting user.\n
  id (required): The unique id of the product being updated.\n
  name (optional): The new name of the updated store if being changed.\n
  email (optional): The new email of the updated store if being changed.\n
  phone (optional): The new phone number of the updated store if being changed.\n
  url (optional): The new url of the updated store if being changed.\n
  owner_id (optional): The new owner id of the updated store if being changed. \n \n \n

  ERRORS IF: \n \n
  - Any required arguments are missing, or any argument is passed as an invalid type. \n
  - The store id passed in is invalid. (You are attempting to update a store that does not exist.) \n
  - The authentication token passed in does not correspond to an owner. (You do not have permission to update this store). \n
  "

  # arguments passed into the update function

  #mandatory args
  argument :token, !types.String
  argument :id, !types.ID

  #optional args
  argument :name, types.String
  argument :email, types.String
  argument :phone, types.String
  argument :url, types.String
  argument :owner_id, types.ID

  # return type
  type Types::StoreType

  def call(_obj, args, _ctx)
    # retrieve the record pertaining to the requesting user and the store to be updated
    store = Store.find_by(id: args[:id])
    req = User.find_for_database_authentication(authentication_token: args[:token])

    # if a new owner_id for the store was passed in, retrieve that user
    if args[:owner_id]
      user = User.find_by(args[:owner_id])
    else
    end

    # verify that the requesting user and store exist, and that the user is the store's owner
    if (req && store && (req.id == store.user_id))

      # instantiate our 'update hash' as empty
      obj = {}

      # go through each optional argument, and if it was passed in add it to the update hash
      if args[:name]
        obj[:name] = args[:name]
      end

      if args[:email]
        obj[:email] = args[:email]
      end

      if args[:phone]
        obj[:phone] = args[:phone]
      end

      if args[:url]
        obj[:url] = args[:url]
      end

      # only add the new owner id if the user it belongs to is already an owner
      if (user && user.owner)
        obj[:user_id] = args[:owner_id]
      end
      # if the hash update is empty, return the unchanged store
      if obj == {}
        return store
      else
        # else update and return the store
        store.update(obj)
        return store
      end
    # error if our validity check failed
    else
      GraphQL::ExecutionError.new("Improper query. Please ensure the user/store is valid, and that you are the owner of the store")
    end
  end

end
