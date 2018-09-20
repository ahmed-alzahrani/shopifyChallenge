class Resolvers::UpdateStore < GraphQL::Function

  # arguments passed into the update function

  #mandatory args
  argument :token, !types.String
  argument :name, !types.String
  argument :email, !types.String
  argument :phone, !types.String
  argument :url, !types.String
  argument :store_id, !types.ID

  #optional args
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
      store.update(
        name: args[:name],
        email: args[:email],
        phone: args[:phone],
        url: args[:url],
      )
      if (user && user.owner)
        store.update(
          user_id: owner_id
        )
      end
      store
    else
      GraphQL::ExecutionError.new("Improper query. Please ensure the user/store is valid, and that you are the owner of the store")
    end
  end

end
