require 'date'
class Resolvers::CreateOrder < GraphQL::Function

  # arguments passed into the function

  argument :userId, !types.ID
  argument :storeId, !types.ID
  argument :items, !types[types.ID]

  type Types::ResultType

  def call(_obj, args, _ctx)
    items = args[:items]
  #  puts "tried to isolate the items lets look"
#    puts items
  #  puts items.length
#    puts "ok you want me to make an  order"
#    puts args[:userId]
#    puts args[:storeId]
#    puts args[:items]
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

    puts "lets look at the items"
    puts items
    puts "lets look at the first item individually"
    puts items[0]

    (0..(items.length - 1)).each do |i|
      item = Item.find(items[i])
      order.items << item
    end
    return OpenStruct.new(result: true)
  end
end
