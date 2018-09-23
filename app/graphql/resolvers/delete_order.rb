class Resolvers::DeleteOrder < GraphQL::Function

  description " A mutation that deletes an order from the the SQLite database. \n

  ARGUMENTS: \n \n
  token (required): An authentication-token representing the user making the request. Only owners can delete orders. \n
  id (required): The id of the order to be deleted. \n \n \n

  ERRORS IF: \n \n
  - Any required arguments are missing, or any argument is passed as an invalid type. \n
  - The order id passed in is invalid. (The order you are attempting to delete does not exist.) \n
  - The authentication token passed in does not represent an owner. (you do not have permission to delete orders). \n
  "

  # required arguments
  argument :token, !types.String
  argument :id, !types.ID

  # return type
  type Types::OrderType

  def call(_obj, args, _ctx)
    # retrieve the records corresponding to the requesting user, the order being deleted, as well as the customer and store that correspond to the order
    req = User.find_for_database_authentication(authentication_token: args[:token])
    order = Order.find_by(args[:id])
    customer = User.find_by(id: order.user_id)
    store = Store.find_by(id: order.store_id)

    # verify existence of the orders
    if order
      # verify that the requesting user exists and has owner rights
      if req && req.owner
        # update the customer and store to remove the order and delete the order
        customer.update(order_count: (customer.order_count - 1), total_spent: (customer.total_spent - order.total))
        store.update(order_count: (store.order_count - 1), total_sold: (store.total_sold - order.total))
        order.destroy
      # else we error if any of the prior checks fail
      else
        GraphQL::ExecutionError.new("You do not have permission to delete orders.")
      end
    else
        GraphQL::ExecutionError.new("The order you are attempting to delete does not exist.")
    end
  end
end
