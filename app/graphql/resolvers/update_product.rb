class Resolvers::UpdateProduct < GraphQL::Function
  argument :token, !types.String
  argument :name, !types.String
  argument :value, !types.Float
  argument :tags, !types.String
  argument :id, !types.ID

  type Types::ProductType


  def call(_obj, args, _ctx)
    req = User.find_for_database_authentication(authentication_token: args[:token])
    target = Product.find_by(id: args[:id])
    if target
      if req && req.owner
        product.update!(
          name: args[:name],
          value: args[:value],
          tags: args[:tags]
        )
        product
      else
        GraphQL::ExecutionError.new("You do not have owner permission to update products.")
      end
    else
      GraphQL::ExecutionError.new("The product you are attempting to update does not exist.")
    end
  end
end
