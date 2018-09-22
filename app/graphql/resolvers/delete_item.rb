class Resolvers::DeleteItem < GraphQL::Function

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
