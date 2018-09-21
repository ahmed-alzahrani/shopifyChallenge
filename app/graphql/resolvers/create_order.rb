require 'date'
class Resolvers::CreateOrder < GraphQL::Function

  # arguments passed into the function

  argument :userId, !types.ID
  argument :token, !types.String
  argument :storeId, !types.ID
  argument :items, !types[types.ID]
  argument :id, !types.ID

  argument :coupon, types.String

  type Types::OrderType

  def call(_obj, args, _ctx)

    # ensure that all of our item ids map onto real items
    items = args[:items]
    order_items = []
    (0..(items.length - 1)).each do |i|
      order_item = Item.find_by(id: items[i])
      if order_item
        order_items << order_item
      else
        # throw if there is an invalid item
        GraphQL::ExecutionError.new("You are attempting to order an invalid item, please review your order and submit again.")
      end
    end

    req = User.find_for_database_authentication(authentication_token: args[:token])
    target = User.find_by(id: args[:id])
    store = Store.find_by(id: args[:storeId])

    # check that the user initiating the request and the user assigned to the order exists
    if req && target && (req.id == target.id || (req.owner && !target.owner))
      if store
        Order.create!(
          created: Date.today,
          subTotal: 0.00,
          savings: 0.00,
          tax: 0.00,
          total: 0.00,
          store_id: args[:storeId],
          user_id: args[:userId]
        )

        order = Order.order("id").last

        (0..(items.length - 1)).each do |i|
          item = Item.find(items[i])
          order.items << item
        end
        return OpenStruct.new(
          id: order.id,
          subTotal: order.subTotal,
          savings: order.savings,
          tax: order.tax,
          total: order.total,
          store_id: order.store_id,
          user_id: order.user_id,
          items: order_items
        )
      else
        GraphQL::ExecutionError.new("You are attempting to process an order for a store that does not exist.")
      end
    else
      GraphQL::ExecutionError.new("You must be logged in, or have the necessary rights to process an order for that user, please check your request and try again")
    end
  end
end
