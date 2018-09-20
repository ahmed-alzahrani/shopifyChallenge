class Resolvers::UpdateOwner < GraphQL::Function

  #args
  argument :token, !types.String
  argument :store_id, !types.ID
  argument :owner_id, !types.ID

  type Types::StoreType

  def call(_obj, args, _ctx)
    store = Store.find_by(id: args[:store_id])
    req = User.find_for_database_authentication(authentication_token: args[:token])
    target = User.find_by(id: args[:owner_id])
    if store
      # the store we want to change exists
      if req && req.owner && target && target.owner
        store.update!(user_id: args[:id])
      else
      end
    else
      GraphQL::ExecutionError.new("The store you're attempting to change ownership of does not exist")
    end
  end
end
