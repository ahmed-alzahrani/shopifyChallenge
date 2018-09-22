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

  type Types::StoreType

  def call(_obj, args, _ctx)
    store = Store.find_by(id: args[:id])
    req = User.find_for_database_authentication(authentication_token: args[:token])
    if args[:owner_id]
      user = User.find_by(args[:owner_id])
    else
    end
    if (req && store && (req.id == store.user_id))
      # the update can take place, populate our update object with any and all optional args passed
      obj = {}

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

      if (user && user.owner)
        obj[:user_id] = args[:owner_id]
      end
      if obj == {}
        return store
      else
        store.update(obj)
        return store
      end
    else
      GraphQL::ExecutionError.new("Improper query. Please ensure the user/store is valid, and that you are the owner of the store")
    end
  end

end
