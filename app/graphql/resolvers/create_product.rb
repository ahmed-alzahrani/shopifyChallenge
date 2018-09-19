class Resolvers::CreateProduct < GraphQL::Function
  #arguments passed as #args
  argument :name, !types.String
  argument :value, !types.Float
  argument :tags, !types.String
  argument :token, !types.String

  type Types::ProductType

  def call(_obj, args, _ctx)
    req = User.find_for_database_authentication(authentication_token: args[:token])
    if req && req.owner
      Product.create!(
        name: args[:name],
        value: args[:value],
        tags: args[:tags],
      )
    else
      GraphQL::ExecutionError.new("You do not have owner rights to create new products")
    end
  end
end
