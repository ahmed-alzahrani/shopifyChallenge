class Resolvers::CreateProduct < GraphQL::Function
  #arguments passed as #args
  argument :name, !types.String
  argument :value, !types.Float
  argument :tags, !types.String
  argument :token, !types.String
  argument :storeId, !types.ID

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
