class Resolvers::CreateOrder < GraphQL::Function

  description " A mutation that creates a new order in the SQLite database. \n

  ARGUMENTS: \n \n
  token (reqired): An authentication-token representing the user making the request. Owners can place orders for themselves and regular customers, customers can only place orders for themselves. \n
  userId (required): A unique id representing the user that this order will belong to. \n
  storeId (required): A unique store id representing the store the order is being made from. \n
  items (required): An array representing the unique ids of items being purchased. \n
  coupon (optional): A string representing a coupon code the user can attempt to pass for a discount. \n \n \n

  ERRORS IF: \n \n
  - Any required arguments are missing, or any argument is passed as an invalid type. \n
  - The token passed in does not belong to an owner or conflicts with the user id. (You must be logged in, or have the necessary rights to process an order for that user) \n
  - The storeId passed in is invalid (You are attempting to process an empty order or an order for a store that does not exist.) \n
  - None of the item ids passed in are valid (You are attempting to process an empty order or an order for a store that does not exist.) \n
  "

  # arguments passed into the function

  # reqired args
  argument :userId, !types.ID
  argument :token, !types.String
  argument :storeId, !types.ID
  argument :items, !types[types.ID]

  # optional arg
  argument :coupon, types.String

  # return type
  type Types::OrderType

  def call(_obj, args, _ctx)

    # ensure that all of our item ids map onto real items
    items = args[:items]
    order_items = []
    # loop through the item ids array
    (0..(items.length - 1)).each do |i|
      # if a corresponding item exists
      if !(Item.where(id: items[i]).empty?)
        # add it to the array
        order_item = Item.find_by(id: items[i])
        order_items << order_item
      else
        # throw if there is an invalid item
        GraphQL::ExecutionError.new("You are attempting to order an invalid item, please review your order and submit again.")
      end
    end

    # find the records pertaining to the requesting user, the user the order is for, and the store the order is from
    req = User.find_for_database_authentication(authentication_token: args[:token])
    target = User.find_by(id: args[:userId])
    store = Store.find_by(id: args[:storeId])

    # check that the user initiating the request and the user assigned to the order exists
    if req && target && (req.id == target.id || (req.owner && !target.owner))
      # check that the store exists and that at least one item is being purchased
      if store && (order_items.length > 0)

        # now we calculate the spending on the order

        # instantiate the subtotal and adjusted at 0
        subtotal = 0.00
        adjusted = 0.00

        # for checking if the user has at least one item in each part of the stack, we initialize all flags to false
        mobile = false
        web = false
        frontend = false
        db = false
        devOps = false
        ide = false

        # loop through the items
        (0..(order_items.length - 1)).each do |i|
          # get the item and its product (so we can asses the tags)
          item = order_items[i]
          product = Product.find_by(id: item.product_id)
          # add the item value to our subtotal
          subtotal  = ((subtotal + item.value) * 100).round / 100.0

          # check the tags of the product, and flip the relevant flag based on the tags
          if (product.tags.include? "mobile")
            mobile = true
          end

          if (product.tags.include? "web")
            web = true
          end

          if (product.tags.include? "front-end")
            frontend = true
          end

          if (product.tags.include? "database")
            db = true
          end

          if (product.tags.include? "text editors/IDEs")
            devOps = true
          end

          if (product.tags.include? "editors/IDEs")
            ide = true
          end
        end

        # IF THE USER HAS AT LEAST ONE ITEM IN EACH PART OF THE STACK
        # THEY ARE ENTITLED TO FREE IDEs AND 10% OFF THEIR ORDER

        free = 0
        if mobile && web && frontend && db && devOps && ide
          (0..(order_items.length - 1)).each do |i|
            # once again get the item and product to asses tags
            item = order_items[i]
            product = Product.find_by(id: item.product_id)
            # all ides/editors are free
            if (product.tags.include? "editors/IDEs")
              free = ((free + item.value) * 100).round / 100.0
            end
          end
          # and the user gets 10% off
          adjusted = ((subtotal - free) * 100).round / 100.0
          adjusted = ((adjusted * 0.9) * 100).round / 100.0
        else
          # the user does not qualify for the sale and their adjusted IS their subtotal
          adjusted = ((subtotal) * 100).round / 100.0
        end

        # lastly check their coupon before we create the order
        # if the coupon is intern-dreams they get 10% off.
        if args[:coupon] && (args[:coupon] == 'intern-dreams')
          adjusted = ((adjusted * 0.9) * 100).round / 100.0
        end

        # generate our tax, all orders taxed at 13%
        tax = ((adjusted * 0.13) * 100).round / 100.0


        # create the order with the monetary values calculated and args we've verified
        Order.create!(
          subTotal: subtotal,
          adjusted: adjusted,
          savings: (((subtotal - adjusted) * 100).round / 100.0),
          tax: tax,
          total: ((adjusted + tax) * 100).round / 100.0,
          store_id: args[:storeId],
          user_id: args[:userId]
        )

        # grab the order we just created
        order = Order.order("id").last

        # populate our join table of orders and items with the relevant items from this order
        (0..(order_items.length - 1)).each do |i|
          order.items << order_items[i]
        end


        # update the store to include the order by adjusting order_count and total_sold
        store.update(
          order_count: (store.order_count += 1),
          total_sold: (((store.total_sold += order.total) * 100).round / 100.0)
        )

        # update the user to include the order by adjusting order_count and total_spent
        target.update(
          order_count: (target.order_count += 1),
          total_spent: (((target.total_spent += order.total) * 100).round / 100.0)
        )

        # return the OrderType to include the items for the client
        return OpenStruct.new(
          id: order.id,
          subTotal: order.subTotal,
          savings: order.savings,
          adjusted: order.adjusted,
          tax: order.tax,
          total: order.total,
          store_id: order.store_id,
          user_id: order.user_id,
          items: order_items
        )
      else
        GraphQL::ExecutionError.new("You are attempting to process an empty order or an order for a store that does not exist.")
      end
    else
      GraphQL::ExecutionError.new("You must be logged in, or have the necessary rights to process an order for that user, please check your request and try again")
    end
  end
end
