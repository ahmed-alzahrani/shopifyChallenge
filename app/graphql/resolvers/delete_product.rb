class Resolvers::DeleteProduct < GraphQL::Function

  description " A mutation that deletes a product from the the SQLite database. \n

  ARGUMENTS: \n \n
  token (required): An authentication-token representing the user making the request. Only owners can delete orders. \n
  id (required): The id of the order to be deleted. \n \n \n

  ERRORS IF: \n \n
  - The product id passed in is invalid. (The product you are attempting to delete does not exist.) \n
  - The authentication token passed in does not represent an owner. (you do not have permission to delete products). \n
  "


  #arguments passed in
  argument :token, !types.String
  argument :id, !types.ID

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
