class Resolvers::DeleteProduct < GraphQL::Function
  #arguments passed in
  argument :id, !types.ID

  type Types::ProductType

  def call(_obj, args, _ctx)
    Product.find(args[:id]).destroy
  end
end
