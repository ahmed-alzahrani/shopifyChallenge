class Resolvers::UpdateStore < GraphQL::Function

  # arguments passed into the update function

  #mandatory args
  argument :token, !types.String
  argument :store_id, !types.ID

  #optional args
  argument :name, types.String
  argument :email, types.String
  argument :phone, types.String
  argument :url, types.String
  argument :owner, types.Boolean, default_value: false
  argument :owner_id, types.ID

  type Types::StoreType

  def call(_obj, args, _ctx)
    store = Store.find_by(id: args[:store_id])
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
        GraphQL::ExecutionError.new("Improper query. Please specify at least one change you would like to make.")
      else
        store.update(obj)
        return store
      end
    else
      GraphQL::ExecutionError.new("Improper query. Please ensure the user/store is valid, and that you are the owner of the store")
    end
  end

end
