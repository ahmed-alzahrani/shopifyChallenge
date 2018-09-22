require 'date'
class Resolvers::CreateOrder < GraphQL::Function

  # arguments passed into the function

  # reqired args
  argument :userId, !types.ID
  argument :token, !types.String
  argument :storeId, !types.ID
  argument :items, !types[types.ID]

  # optional args
  argument :coupon, types.String

  type Types::OrderType

  def call(_obj, args, _ctx)

    # ensure that all of our item ids map onto real items
    items = args[:items]
    order_items = []
    (0..(items.length - 1)).each do |i|
      if !(Item.where(id: items[i]).empty?)
        order_item = Item.find_by(id: items[i])
        order_items << order_item
      else
        # throw if there is an invalid item
        GraphQL::ExecutionError.new("You are attempting to order an invalid item, please review your order and submit again.")
      end
    end

    req = User.find_for_database_authentication(authentication_token: args[:token])
    target = User.find_by(id: args[:userId])
    store = Store.find_by(id: args[:storeId])

    # check that the user initiating the request and the user assigned to the order exists
    if req && target && (req.id == target.id || (req.owner && !target.owner))
      if store && (order_items.length > 0)

        # now we calculate the spending on the order
        subtotal = 0.00
        adjusted = 0.00

        # for checking if the user has at least one item in each part of the stack
        mobile = false
        web = false
        frontend = false
        db = false
        devOps = false
        ide = false

        # loop through the item
        (0..(order_items.length - 1)).each do |i|
          # get the item and its product (so we can asses the tags)
          item = order_items[i]
          product = Product.find_by(id: item.product_id)
          # add the item value to our subtotal
          subtotal  = ((subtotal + item.value) * 100).round / 100.0

          # CHECK THE TAGS, AND FLIP RELEVANT FLAG IF A CERTAIN TAG IS PRESENT
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

        tax = ((adjusted * 0.13) * 100).round / 100.0


        Order.create!(
          created: Date.today,
          subTotal: subtotal,
          adjusted: adjusted,
          savings: (((subtotal - adjusted) * 100).round / 100.0),
          tax: tax,
          total: ((adjusted + tax) * 100).round / 100.0,
          store_id: args[:storeId],
          user_id: args[:userId]
        )

        order = Order.order("id").last

        (0..(order_items.length - 1)).each do |i|
          order.items << order_items[i]
        end


        # update the store to include the order
        store.update(
          order_count: (store.order_count += 1),
          total_sold: (((store.total_sold += order.total) * 100).round / 100.0)
        )

        # update the user to include the order
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
