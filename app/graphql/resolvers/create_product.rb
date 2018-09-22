class Resolvers::CreateProduct < GraphQL::Function

  description " A mutation that creates a new product in the SQLite database. \n

  ARGUMENTS: \n \n
  token (reqired): An authentication-token representing the user making the request. Only owners can create products. \n
  storeId (required): A unique store id representing the store the product is being made for. \n
  name (required): A string representing the new product\'s name \n
  value (required): A float representingthe new product\'s base price. \n
  tags (required): A string representing the various sub-categories that products can be searched by. \n \n \n

  ERRORS IF: \n \n
  - The token passed in does not belong to an owner. (You do not have owner rights to create new products) \n
  - The storeId passed in is invalid (You are attempting to create a product for a store that does not exist.) \n
  "

  #arguments passed as #args
  argument :token, !types.String
  argument :storeId, !types.ID
  argument :name, !types.String
  argument :value, !types.Float
  argument :tags, !types.String

  type Types::ProductType

  def call(_obj, args, _ctx)
    req = User.find_for_database_authentication(authentication_token: args[:token])
    store = Store.find_by(id: args[:storeId])
    if req && req.owner
      if store
        product = Product.create!(
          name: args[:name],
          value: args[:value],
          tags: args[:tags],
          store_id: args[:storeId]
        )

        product_items = []
        Item.where(product_id: product.id).find_each do |item|
          product_items.push(item)
        end

        return OpenStruct.new(
          id: product.id,
          store_id: product.store_id,
          name: product.name,
          value: product.value,
          tags: product.tags,
          items: product_items
        )
      else
        GraphQL::ExecutionError.new("You are attempting to create a product for a store that does not exist.")
      end
    else
      GraphQL::ExecutionError.new("You do not have owner rights to create new products")
    end
  end
end
