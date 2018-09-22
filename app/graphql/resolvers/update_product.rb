class Resolvers::UpdateProduct < GraphQL::Function
  #required args
  argument :token, !types.String
  argument :id, !types.ID

  #optional args
  argument :name, types.String
  argument :value, types.Float
  argument :tags, types.String

  type Types::ProductType


  def call(_obj, args, _ctx)
    req = User.find_for_database_authentication(authentication_token: args[:token])
    target = Product.find_by(id: args[:id])
    if target
      if req && req.owner
        obj = {}

        if args[:name]
          obj[:name] = args[:name]
        end

        if args[:value]
          obj[:value] = args[:value]
        end

        if args[:tags]
          obj[:tags] = args[:tags]
        end

        if obj == {}
          GraphQL::ExecutionError.new("Improper query. Please specify at least one change you would like to make.")
        else
          target.update!(
            obj
          )
          product_items = []
          Item.where(product_id: target.id).find_each do |item|
            product_items.push(item)
          end

          return OpenStruct.new(
            id: target.id,
            store_id: target.store_id,
            name: target.name,
            value: target.value,
            tags: target.tags,
            items: product_items
          )
        end
      else
        GraphQL::ExecutionError.new("You do not have owner permission to update products.")
      end
    else
      GraphQL::ExecutionError.new("The product you are attempting to update does not exist.")
    end
  end
end
