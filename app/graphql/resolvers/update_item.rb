class Resolvers::UpdateItem < GraphQL::Function

  argument :token, !types.String
  argument :id, !types.ID
  argument :productId, !types.ID

  argument :name, types.String
  argument :value, types.Float

  type Types::ItemType

  def call(_obj, args, _ctx)
    req = User.find_for_database_authentication(authentication_token: args[:token])
    target = Item.find_by(id: args[:id])
    product = Product.find_by(id: args[:productId])

    if product && target
      if req && req.owner
        obj = {}

        if args[:name]
          obj[:name] = args[:name]
        end

        if args[:value] && args[:value] >= product.value
          obj[:value] = args[:value]
        end

        if obj == {}
          GraphQL::ExecutionError.new("Improper query. Please specify at least one change you wish to make.")
        end
        target.update!(obj)
        target
      else
        GraphQL::ExecutionError.new("You do not have permission to update items.")
      end
    else
      GraphQL::ExecutionError.new("You are attempting to update an item that does not exist.")
    end
  end
end
