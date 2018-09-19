class Resolvers::DeleteProduct < GraphQL::Function
  #arguments passed in
  argument :id, !types.ID
  argument :token, !types.String

  type Types::ProductType

  def call(_obj, args, _ctx)
    req = User.find_for_database_authentication(authentication_token: args[:token])
    product = Product.find(args[:id])

    if product
      if req && req.owner
        product.destroy
      else
        GraphQL::ExecutionError.new("You do not have owner permission to update products.")
      end
    else
      GraphQL::ExecutionError.new("The product you are attempting to destroy does not exist.")
    end
  end
end
