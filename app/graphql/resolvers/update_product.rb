class Resolvers::UpdateProduct < GraphQL::Function

  description" A mutation that updates a product from the SQLite database. Only owners can update products. If no optional args are passed,
  the item remains unchanged and is returned in it\'s current state. Updating a product also resets its items, so that there are only three,
  following the original structure of base (+$0), +1 year service (+$10), and +2 year service (+$20)

  ARGUMENTS: \n \n
  token (required): An authentication token passed in by the requesting user.\n
  id (required): The unique id of the product being updated.\n
  name (optional): The new name of the updated item if being changed.\n
  value (optional): The new value of the updated item if being changed.\n
  tags (optional): The new tags of the updated item if being changed. \n \n \n

  ERRORS IF: \n \n
  - Any required arguments are missing, or any argument is passed as an invalid type. \n
  - The product id passed in is invalid. (You are attempting to update a product that does not exist.) \n
  - The authentication token passed in does not correspond to an owner. (You do not have permission to update products). \n
  "

  #required args
  argument :token, !types.String
  argument :id, !types.ID

  #optional args
  argument :name, types.String
  argument :value, types.Float
  argument :tags, types.String

  # return type
  type Types::ProductType

  def call(_obj, args, _ctx)
    # retrieve the records for the requesting user, and the product to be updated
    req = User.find_for_database_authentication(authentication_token: args[:token])
    target = Product.find_by(id: args[:id])

    # verify the product exists
    if target
      # verify the requesting user exists and has owner rights
      if req && req.owner

        # instantiate our 'update hash' as empty
        obj = {}

        # go through each optional argument, add it to the hash if it exists
        if args[:name]
          obj[:name] = args[:name]
        end

        if args[:value]
          obj[:value] = args[:value]
        end

        if args[:tags]
          obj[:tags] = args[:tags]
        end

        # if the hash is empty, return the unchanged target product
        if obj == {}
          target

        # else we update the product and return it
        else
          target.update!(
            obj
          )

          # get all of the items pertaining to the product
          product_items = []
          Item.where(product_id: target.id).find_each do |item|
            product_items.push(item)
          end

          # return the product and items
          return OpenStruct.new(
            id: target.id,
            store_id: target.store_id,
            name: target.name,
            value: target.value,
            tags: target.tags,
            items: product_items
          )
        end
      # error if any of the prior checks failed
      else
        GraphQL::ExecutionError.new("You do not have owner permission to update products.")
      end
    else
      GraphQL::ExecutionError.new("The product you are attempting to update does not exist.")
    end
  end
end
