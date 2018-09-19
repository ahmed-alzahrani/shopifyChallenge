class Resolvers::UpdateStore < GraphQL::Function

  # arguments passed into the update function
  argument :token, !types.String
  argument :name, !types.String
  argument :email, !types.String
  argument :phone, !types.String
  argument :url, !types.String
  argument :store_id, !types.ID

  type Types::StoreType

  def call(_obj, args, _ctx)
    #@store = Store.find_for_database_authentication(id: args[:store_id])
    if Store.exists?(args[:store_id])
      store = Store.find_by(id: args[:store_id])
    end
    @user = User.find_for_database_authentication(authentication_token: args[:auth_token])
    if (@user && store && (@user.id == store.user_id))
      store.update!(
        name: args[:name],
        email: args[:email],
        phone: args[:phone],
        url: args[:url],
      )
      store
    else
      GraphQL::ExecutionError.new("Improper query. Please ensure the user/store is valid, and that you are the owner of the store")
    end
  end

end
