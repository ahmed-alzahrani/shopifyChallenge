class Resolvers::DeleteOrder < GraphQL::Function

  description " A mutation that deletes an order from the the SQLite database. \n

  ARGUMENTS: \n \n
  token (required): An authentication-token representing the user making the request. Only owners can delete orders. \n
  id (required): The id of the order to be deleted. \n \n \n

  ERRORS IF: \n \n
  - The order id passed in is invalid. (The order you are attempting to delete does not exist.) \n
  - The authentication token passed in does not represent an owner. (you do not have permission to delete orders). \n
  "

  argument :token, !types.String
  argument :id, !types.ID

  type Types::OrderType

  def call(_obj, args, _ctx)
    req = User.find_for_database_authentication(authentication_token: args[:token])
    order = Order.find_by(args[:id])
    customer = User.find_by(id: order.user_id)
    store = Store.find_by(id: order.store_id)

    if order
      if req && req.owner
        customer.update(order_count: (customer.order_count - 1), total_spent: (customer.total_spent - order.total))
        store.update(order_count: (store.order_count - 1), total_sold: (store.total_sold - order.total))
        order.destroy
      else
        GraphQL::ExecutionError.new("You do not have permission to delete orders.")
      end
    else
        GraphQL::ExecutionError.new("The order you are attempting to delete does not exist.")
    end
  end
end
