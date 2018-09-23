class Resolvers::DeleteProduct < GraphQL::Function

  description " A mutation that deletes a product from the the SQLite database. \n

  ARGUMENTS: \n \n
  token (required): An authentication-token representing the user making the request. Only owners can delete orders. \n
  id (required): The id of the order to be deleted. \n \n \n

  ERRORS IF: \n \n
  - The product id passed in is invalid. (The product you are attempting to delete does not exist.) \n
  - The authentication token passed in does not represent an owner. (you do not have permission to delete products). \n
  "

  # arguments passed in

  # required args
  argument :token, !types.String
  argument :id, !types.ID

  # return type
  type Types::ProductType

  def call(_obj, args, _ctx)
    # retrieve the records corresponding to the requesting user and the product to be deleted
    req = User.find_for_database_authentication(authentication_token: args[:token])
    product = Product.find(args[:id])

    # verify the product exists
    if product
      # verify the requesting user both exists and has owner rights
      if req && req.owner
        # destory the product
        product.destroy
      # else we error if any of the prior checks fail
      else
        GraphQL::ExecutionError.new("You do not have owner permission to update products.")
      end
    else
      GraphQL::ExecutionError.new("The product you are attempting to destroy does not exist.")
    end
  end
end
