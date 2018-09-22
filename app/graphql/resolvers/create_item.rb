class Resolvers::CreateItem < GraphQL::Function

  argument :token, !types.String
  argument :storeId, !types.ID
  argument :productId, !types.ID
  argument :name, !types.String
  argument :value, !types.Float

  type Types::ItemType

  def call(_obj, args, _ctx)
    req = User.find_for_database_authentication(authentication_token: args[:token])
    store = Store.find_by(id: args[:storeId])
    product = Product.find_by(id: args[:productId])

    if req && req.owner
      if store
        if product
          if args[:value] >= product.value
            Item.create!(
              product_id: args[:productId],
              name: args[:name],
              value: args[:value]
            )
          else
            GraphQL::ExecutionError.new("You can not create an item at less than the value of its product.")
          end
        else
          GraphQL::ExecutionError.new("You are attempting to add an item to a product that does not exist.")
        end
      else
        GraphQL::ExecutionError.new("You are attempting to add an item to a store that does not exist.")
      end
    else
      GraphQL::ExecutionError.new("You do not have owner rights to create new items")
    end

  end
end
